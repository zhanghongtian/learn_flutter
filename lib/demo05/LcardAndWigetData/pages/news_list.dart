import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/news_manager.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/logout.dart';

class NewsListPage extends StatefulWidget {
  final MainScopeModel model;
  NewsListPage({Key key, this.model}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchNews();
    print("初始化news");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
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
                    Icons.edit,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("管理资讯"),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/admin');
                  },
                ),
                Logout()
              ],
            ),
          ),
          appBar: new AppBar(
            title: Text("资讯标题"),
            actions: [
              IconButton(
                  icon: Icon(
                    model.displayFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 22,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    model.toggleDisplayModel();
                  })
            ],
          ),
          body: NewsManager(),
        );
      },
    );
  }
}
