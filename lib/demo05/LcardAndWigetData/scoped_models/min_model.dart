import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/response_common_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/user_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/utils/http.dart';
import 'package:scoped_model/scoped_model.dart';

enum AuthMode { Singup, Login }

class MixModel extends Model {
  List<NewsModel> _news = [];
  String _selectedNewsId; // 选中的资讯下标
  bool _showFavorites = false; //过滤内收藏内容的状态
  UserModel _user;
  bool _isLoading = false; // 是否显示加载条

  bool get isLoading {
    return _isLoading;
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
     * 查看功能
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
        await postJson('http://39.107.155.171:7767/news-pai/addNews', data: {
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

  Future<Null> fetchNews() async {
    /**
     * 获取所有的资讯
     */
    _isLoading = true;
    final List<NewsModel> getNewsList = [];
    getRequest("http://39.107.155.171:7767/news-pai/allNewsList")
        .then((response) {
      var data = json.decode(response.toString());
      ResponseCommonBean responseCommonBean = ResponseCommonBean.from(data);
      List<NewsModel> newsModel = responseCommonBean.data;
      newsModel.forEach((NewsModel newsData) {
        NewsModel newsModel = NewsModel(
            id: newsData.id,
            title: newsData.title,
            description: newsData.description,
            score: newsData.score,
            imageUrl: newsData.imageUrl,
            isFavorite: newsData.isFavorite,
            userName: newsData.userName);
        getNewsList.add(newsModel);
      });
      _news = getNewsList;
      _isLoading = false;
      notifyListeners();
    });
    print("获取完数据");
  }

  void deleteNews() {
    /**
     * 删除功能
     */
    postJson(
            'http://39.107.155.171:7767/news-pai/deleteNews/${selectedNews.id}')
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
    postJson('http://39.107.155.171:7767/news-pai/addNews', data: {
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
    NewsModel news = NewsModel(
        title: selectedNews.title,
        description: selectedNews.description,
        imageUrl: selectedNews.imageUrl,
        score: selectedNews.score,
        isFavorite: newValue);
    final _selectedIndex = _news.indexWhere((NewsModel news) {
      return news.id == _selectedNewsId;
    });
    _news[_selectedIndex] = news;
    _selectedNewsId = null;
    notifyListeners();
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
}

/**
 * 用户模型的状态管理
 */
mixin UserScopeMedol on MixModel {
  Future<Map<String, dynamic>> login(String username, String password) async {
    _isLoading = true;
    print("username:" + username + '\t' + 'password:' + password);
    Map<String, dynamic> result = {'success': false, 'massage': '注册失败'};
    // 方法中异步方法
    Response response = await postForm(
        "http://39.107.155.171:7767/news-api/login",
        data: {"username": username, "password": password});
    print(response);
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      Map<String, dynamic> data = Map.from(response.data);
      if (data['code'] == 0) {
        Map<String, dynamic> userInfo = data['data'];
        result = {'success': true, 'massage': '登录成功'};
        _user = UserModel(
            id: userInfo['id'], userName: username, password: password);
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
  }

  Future<Map<String, dynamic>> singup(String username, String password) async {
    _isLoading = true;
    print("username:" + username + '\t' + 'password:' + password);
    Map<String, dynamic> result = {'success': false, 'massage': '注册失败'};
    // 方法中异步方法
    Response response = await postForm(
        "http://39.107.155.171:7767/news-api/signup",
        data: {"username": username, "password": password});
    print(response);
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      Map<String, dynamic> data = Map.from(response.data);
      if (data['code'] == 0) {
        result = {'success': true, 'massage': '注册成功'};
      }
      if (data['code'] == 101) {
        result = {'success': false, 'massage': '用户已经注册'};
      }
    }
    _isLoading = false;
    return result;
  }
}
