import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/news_control.dart';

/**
 *知识点：
 * todo - 使用自定的小部件
 */
import 'news.dart';

class NewsManager extends StatelessWidget {
  final List<Map<String,String>> _news;
  final Function _addNews;
  final Function _deleteNews;


  NewsManager(this._news, this._addNews, this._deleteNews);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewsControl(addNews: _addNews),
        News(
          news: _news,
          deleteNews: _deleteNews,
        )
      ],
    );
  }

}
