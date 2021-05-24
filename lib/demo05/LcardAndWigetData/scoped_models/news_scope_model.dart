import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';
import 'package:scoped_model/scoped_model.dart';

/**
 * 管理状态数据
 */
class NewsScopeModel extends Model {
  List<NewsModel> _news = [];
  int _selectedIndex;

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
    NewsModel n =  _news[_selectedIndex];
    return n;
  }

  void selectNews(int index) {
    _selectedIndex = index;
  }

  void addNews(NewsModel news) {
    _news.add(news);
    _selectedIndex = null;
  }

  void deleteNews() {
    // if (_news.length >= _selectedIndex) {
    _news.removeAt(_selectedIndex);
    _selectedIndex = null;
    // }
  }

  void updateNews(NewsModel news) {
    _news[_selectedIndex] = news;
    _selectedIndex = null;
  }
}
