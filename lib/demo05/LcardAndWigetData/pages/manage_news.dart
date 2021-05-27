import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/my_news.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/news_list.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'edit_news.dart';

class ManagerNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
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
                        title: Text("资讯列表"),
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return NewsListPage(model: model);
                          }));
                        },
                      )
                    ],
                  ),
                ),
                appBar: new AppBar(
                  title: Text("管理资讯"),
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
                  children: [EditNewsPage(), MyNewsPage()],
                )));
      },
    );
  }
}
