import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/common.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/response_common_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/user_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/utils/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { Singup, Login }

class MixModel extends Model {
  List<NewsModel> _news = [];
  String _selectedNewsId; // 选中的资讯下标
  bool _showFavorites = false; //过滤内收藏内容的状态
  UserModel _user;
  bool _isLoading = false; // 是否显示加载条
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject<bool>();

  bool get isLoading {
    return _isLoading;
  }

  void toggleLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }
}

/**
 * 管理状态数据
 */
mixin NewsScopeModel on MixModel {
  String get selectedNewsId {
    // 获取选择下标的方法
    return _selectedNewsId;
  }

  List<NewsModel> get newsList {
    return List.from(_news);
  }

  NewsModel get selectedNews {
    if (_selectedNewsId == null) {
      return null;
    }
    return _news.firstWhere((NewsModel news) {
      return news.id == _selectedNewsId;
    });
  }

  void selectNews(String newsId) {
    /**
     * 设置当前选中的newsId
     */
    _selectedNewsId = newsId;
  }

  Future<bool> addNews(Map<String, String> _formData) async {
    /**
     * 添加功能
     */
    bool isSuccess = true;
    NewsModel newNews = new NewsModel(
        title: _formData['title'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl'],
        score: double.parse(_formData['score']),
        userName: _user.userName);
    Response response =
        await postJson(CommonConfig.HOST + '/news-api/addNews', data: {
      "title": newNews.title,
      "description": newNews.description,
      "score": newNews.score.toString(),
      "imageUrl": newNews.imageUrl,
      "isFavorite": newNews.isFavorite.toString(),
      "userName": newNews.userName
    });
    print(response);
    Map data = Map.from(response.data);
    print(data['code']);
    if (null != response &&
        (response.statusCode == 200 || response.statusCode == 201) &&
        data['code'] == 0) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    _isLoading = false;
    _selectedNewsId = null;
    notifyListeners();
    return isSuccess;
  }

  Future<Null> fetchNews({onlyForUser: false}) async {
    /**
     * 获取所有的资讯
     */
    _isLoading = true;
    final List<NewsModel> getNewsList = [];
    getRequest(CommonConfig.HOST + "/news-api/allNewsList").then((response) {
      var data = json.decode(response.toString());
      print(response.toString());
      ResponseCommonBean responseCommonBean = ResponseCommonBean.from(data);
      List<NewsModel> newsModel = responseCommonBean.data;
      newsModel.forEach((NewsModel newsData) {
        NewsModel newsModel = NewsModel(
            id: newsData.id,
            title: newsData.title,
            description: newsData.description,
            score: newsData.score,
            imageUrl: newsData.imageUrl,
            isFavorite: newsData.favoriteUserList.contains(_user.id),
            userName: newsData.userName);
        getNewsList.add(newsModel);
      });
      if (onlyForUser) {
        _news = getNewsList.where((NewsModel news) {
          return news.userName == _user.userName;
        }).toList();
      } else {
        _news = getNewsList;
      }
      _isLoading = false;
      notifyListeners();
    });
    print("获取完数据");
  }

  void deleteNews() {
    /**
     * 删除功能
     */
    postJson(CommonConfig.HOST + '/news-api/deleteNews/${selectedNews.id}')
        .then((Response reponese) {
      if (null != reponese) {
        print(reponese.data);
      }
      fetchNews();
    });
    _selectedNewsId = null;
  }

  Future<Null> updateNews(Map<String, String> _formData) async {
    /**
     * 更新功能
     */
    NewsModel newNews = new NewsModel(
        id: selectedNews.id,
        title: _formData['title'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl'],
        score: double.parse(_formData['score']),
        userName: _user.userName);
    postJson(CommonConfig.HOST + '/news-api/addNews', data: {
      "id": newNews.id,
      "title": newNews.title,
      "description": newNews.description,
      "score": newNews.score.toString(),
      "imageUrl": newNews.imageUrl,
      "isFavorite": newNews.isFavorite.toString(),
      "userName": newNews.userName
    }).then((Response reponese) {
      if (null != reponese) {
        print(reponese.data);
      }
    });
    _selectedNewsId = null;
  }

  void toggleFavorite() {
    /**
     * 收藏功能
     */
    bool currentValue = selectedNews.isFavorite;
    bool newValue = !currentValue;
    String url = newValue
        ? CommonConfig.HOST + "/news-api/withNews"
        : CommonConfig.HOST + "/news-api/noWithNews";
    postForm(url, data: {"newsId": selectedNews.id, "userId": _user.id})
        .then((Response response) {
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        NewsModel news = NewsModel(
            id: selectedNews.id,
            title: selectedNews.title,
            description: selectedNews.description,
            imageUrl: selectedNews.imageUrl,
            score: selectedNews.score,
            isFavorite: newValue,
            userName: _user.userName,
            favoriteUserList: selectedNews.favoriteUserList);
        final _selectedIndex = _news.indexWhere((NewsModel news) {
          return news.id == _selectedNewsId;
        });
        _news[_selectedIndex] = news;
      }
      _selectedNewsId = null;
      notifyListeners();
    });
  }

  bool get displayFavorite {
    return _showFavorites;
  }

  void toggleDisplayModel() {
    /**
     * 切换过滤的状态
     */
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  List<NewsModel> get displayNews {
    /**
     * 过滤后的资讯
     */
    if (_showFavorites) {
      return List.from(_news.where((element) {
        // 过滤掉isFavorite为false的
        return element.isFavorite;
      }).toList());
    } else {
      return List.from(_news);
    }
  }

  void resetSelectedNews() {
    /**
     * 重置选中的资讯id
     */
    _selectedNewsId = null;
  }

  Future<String> uploadFile(File file) async {
    /**
     * 上传文件
     */
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last)
    });
    Response response = await postForm(
        CommonConfig.HOST + '/news-api/uploadFile',
        data: formData);
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      Map<String, dynamic> data = Map.from(response.data);
      if (data['code'] == 0) {
        var url = data['data']['url'];
        return url;
      }
    }
    return null;
  }
}

/**
 * 用户模型的状态管理
 */
mixin UserScopeMedol on MixModel {
  UserModel get user {
    return _user;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    _isLoading = true;
    try {
      print("username:" + username + '\t' + 'password:' + password);
      Map<String, dynamic> result = {'success': false, 'massage': '注册失败'};
      // 方法中异步方法
      Response response = await postForm(CommonConfig.HOST + "/news-api/login",
          data: {"username": username, "password": password});
      print(response);
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        Map<String, dynamic> data = Map.from(response.data);
        if (data['code'] == 0) {
          Map<String, dynamic> userInfo = data['data'];
          result = {'success': true, 'massage': '登录成功'};
          _user = UserModel(
              id: userInfo['id'].toString(),
              userName: username,
              password: password,
              token: userInfo['token']);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('userId', userInfo['id'].toString());
          sharedPreferences.setString('username', username);
          sharedPreferences.setString('token', userInfo['token']);
          _userSubject.add(true);
          recordExpiryTime(sharedPreferences, userInfo['expires']);
        }
        if (data['code'] == 102) {
          result = {'success': false, 'massage': '不存在这个用户'};
        }
        if (data['code'] == 103) {
          result = {'success': false, 'massage': '密码不正确'};
        }
      }
      _isLoading = false;
      return result;
    } catch (e) {
      _isLoading = false;
      return null;
    }
  }

  Future<Map<String, dynamic>> singup(String username, String password) async {
    _isLoading = true;
    try {
      print("username:" + username + '\t' + 'password:' + password);
      Map<String, dynamic> result = {'success': false, 'massage': '注册失败'};
      // 方法中异步方法
      Response response = await postForm(CommonConfig.HOST + "/news-api/signup",
          data: {"username": username, "password": password});
      print(response);
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        Map<String, dynamic> data = Map.from(response.data);
        if (data['code'] == 0) {
          result = {'success': true, 'massage': '注册成功'};
          Map<String, dynamic> userInfo = data['data'];
          _user = UserModel(
              id: userInfo['id'].toString(),
              userName: username,
              password: password,
              token: userInfo['token']);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('userId', userInfo['id'].toString());
          sharedPreferences.setString('username', username);
          sharedPreferences.setString('token', userInfo['token']);
          _userSubject.add(true);
          recordExpiryTime(sharedPreferences, userInfo['expires']);
        }
        if (data['code'] == 101) {
          result = {'success': false, 'massage': '用户已经注册'};
        }
      }
      _isLoading = false;
      return result;
    } catch (e) {
      _isLoading = false;
      return null;
    }
  }

  void autoAuthenticate() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get('token');
    String username = sharedPreferences.get('username');
    String userId = sharedPreferences.get('userId');
    print("token" + token);
    print("username" + username);
    if (null != token) {
      DateTime expiryTimePoint =
          DateTime.parse(sharedPreferences.getString('expiryTimePoint'));
      DateTime now = DateTime.now();
      if (expiryTimePoint.isBefore(now)) {
        _user = null;
        _userSubject.add(false);
        // notifyListeners();
        return;
      }
      _user = UserModel(id: userId, userName: username, token: token);
      int tokenLeft = expiryTimePoint.difference(now).inSeconds;
      setTimeOut(tokenLeft);
      _userSubject.add(true);
      // notifyListeners();
    }
  }

  Future<Null> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    _user = null;
    _authTimer.cancel();
    _userSubject.add(false);
    // notifyListeners();
  }

  void setTimeOut(int expiresTime) {
    /**
     * 计时器
     */
    _authTimer = Timer(Duration(seconds: expiresTime), () async {
      print("自动退出");
      logout();
    });
  }

  void recordExpiryTime(SharedPreferences sharedPreferences, int expires) {
    DateTime now = DateTime.now();
    DateTime expiryTime = now.add(Duration(seconds: expires));
    sharedPreferences.setString('expiryTimePoint', expiryTime.toString());
    setTimeOut(expires);
  }

  PublishSubject get userSubject {
    return _userSubject;
  }
}
