import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/news_manager.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/manage_news.dart';

class NewsListPage extends StatelessWidget {
  final List<Map<String,String>> _news;
  final Function _addNews;
  final Function _deleteNews;


  NewsListPage(this._news, this._addNews, this._deleteNews);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // 抽屉式导航
        child: Column(
          children: [
            AppBar(
              title: Text("选择"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Text("管理咨询"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: Text("资讯标题"),
      ),
      body: NewsManager(_news,_addNews,_deleteNews),
    );
  }
}