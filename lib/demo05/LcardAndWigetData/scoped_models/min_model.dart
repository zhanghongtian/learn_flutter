import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/response_common_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/user_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/utils/http.dart';
import 'package:scoped_model/scoped_model.dart';

class MixModel extends Model {
  List<NewsModel> _news = [];
  int _selectedIndex; // 选中的资讯下标
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
  int get selectedIndex {
    // 获取选择下标的方法
    return _selectedIndex;
  }

  List<NewsModel> get newsList {
    return List.from(_news);
  }

  NewsModel get selectedNews {
    if (_selectedIndex == null) {
      return null;
    }
    NewsModel n = _news[_selectedIndex];
    return n;
  }

  void selectNews(int index) {
    /**
     * 查看功能
     */
    _selectedIndex = index;
  }

  Future<Null> addNews(Map<String, String> _formData) async {
    /**
     * 添加功能
     */

    NewsModel newNews = new NewsModel(
        title: _formData['title'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl'],
        score: double.parse(_formData['score']),
        userName: _user.userName);
    postJson('http://39.107.155.171:7767/news-pai/addNews', data: {
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
    _selectedIndex = null;
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
    _selectedIndex = null;
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
    _selectedIndex = null;
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
    _news[_selectedIndex] = news;
    _selectedIndex = null;
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
}

/**
 * 用户模型的状态管理
 */
mixin UserScopeMedol on MixModel {
  void login(String userName, String password) {
    _user = UserModel(id: '1', userName: userName, password: password);
  }
}
