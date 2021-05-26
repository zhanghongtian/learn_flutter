import 'dart:convert';

import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/user_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/utils/http.dart';

class MixModel {
  List<NewsModel> _news = [];
  int _selectedIndex; // 选中的资讯下标
  bool _showFavorites = false; //过滤内收藏内容的状态
  UserModel _user;
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
    _selectedIndex = null;
    return n;
  }

  void selectNews(int index) {
    /**
     * 查看功能
     */
    _selectedIndex = index;
  }

  void addNews(Map<String, String> _formData) {
    /**
     * 添加功能
     */

    NewsModel newNews = new NewsModel(
        title: _formData['title'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl'],
        score: double.parse(_formData['score']),
        userName: _user.userName);
    requestJson('http://39.107.155.171:7767/news-pai/addNews', data: {
      "title": newNews.title,
      "description": newNews.description,
      "score": newNews.score.toString(),
      "imageUrl": newNews.imageUrl,
      "isFavorite": newNews.isFavorite.toString(),
      "userName": newNews.userName
    }).then((reponese) => print(reponese.statusCode));
    _news.add(newNews);
    _selectedIndex = null;
  }

  void deleteNews() {
    /**
     * 删除功能
     */
    // if (_news.length >= _selectedIndex) {
    _news.removeAt(_selectedIndex);
    _selectedIndex = null;
    // }
  }

  void updateNews(Map<String, String> _formData) {
    /**
     * 更新功能
     */
    NewsModel newNews = new NewsModel(
        title: _formData['title'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl'],
        score: double.parse(_formData['score']),
        userName: _user.userName);
    _news[_selectedIndex] = newNews;
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
    // notifyListeners();
  }

  bool get displayFavorite {
    return _showFavorites;
  }

  void toggleDisplayModel() {
    /**
     * 切换过滤的状态
     */
    _showFavorites = !_showFavorites;
    // notifyListeners();
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
