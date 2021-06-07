import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/edit_news.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyNewsPage extends StatefulWidget {
  final MainScopeModel model;
  MyNewsPage({Key key, this.model}) : super(key: key);

  @override
  _MyNewsPageState createState() => _MyNewsPageState();
}

class _MyNewsPageState extends State<MyNewsPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return Scaffold(
            body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            Key key = Key(model.newsList[index].title);
            return Dismissible(
                key: key,
                onDismissed: (DismissDirection direction) {
                  //当滑动删除的时候，会调用此方法
                  if (direction == DismissDirection.endToStart) {
                    model.selectNews(model.newsList[index].id);
                    model.deleteNews();
                  }
                },
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.newsList[index].imageUrl)),
                  title: Text(model.newsList[index].title),
                  subtitle: Text(model.newsList[index].score.toString()),
                  trailing: _buildEditButton(
                      context, model.newsList[index].id, model),
                ));
          },
          itemCount: model.newsList.length,
        ));
      },
    );
  }

  Widget _buildEditButton(
      BuildContext context, String newsId, MainScopeModel model) {
    return IconButton(
      iconSize: 20,
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          model.selectNews(newsId);
          return EditNewsPage();
        }));
      },
    );
  }
}
