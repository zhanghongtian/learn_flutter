import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/my_news.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/news_list.dart';

import 'create_news.dart';

class ManagerNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  AppBar(
                    title: Text("选择"),
                  ),
                  ListTile(
                    title: Text("咨询列表"),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        // return NewsListPage();
                      }));
                    },
                  )
                ],
              ),
            ),
            appBar: new AppBar(
              title: Text("管理咨询"),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "创建资讯",
                    icon: Icon(Icons.create),
                  ),
                  Tab(
                    text: "我的资讯",
                    icon: Icon(Icons.edit),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [CreateNewsPagePage(), MyNews()],
            )));
  }
}
