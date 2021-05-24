import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/news_manager.dart';

class NewsListPage extends StatelessWidget {
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
              leading: Icon(
                Icons.favorite,
                size: 20,
                color: Colors.red,
              ),
              title: Text("管理资讯"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: Text("资讯标题"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.favorite,
                size: 22,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: NewsManager(),
    );
  }
}
