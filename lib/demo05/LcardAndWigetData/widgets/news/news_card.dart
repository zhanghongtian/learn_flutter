import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

import 'score.dart';

class NewsCard extends StatelessWidget {
  final int index;

  const NewsCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return Card(
          child: Column(
            children: <Widget>[
              Image.network(model.newsList[index].imageUrl,
                  width: 400, height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 15,
                      child: TitleDefault(model.newsList[index].title)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Score(model.newsList[index].score.toString()),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(model.newsList[index].userName),
                  ),
                ],
              ),
              ButtonBar(
                children: [
                  TextButton(
                    child: Text('详情'),
                    onPressed: () {
                      // Navigator.push<bool>(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return NewsDetailPage(
                      //     title: news[index]['title'],
                      //     imageUrl: news[index]['imageUrl'],
                      //   );
                      // })).then((value) {
                      //   print(value);
                      //   if (value) {
                      //     deleteNews(index);
                      //   }
                      // });
                      Navigator.pushNamed(context,
                              "/news/" + index.toString())
                          .then((value) {
                        print(value);
                        if (value) {
                          model.selectNews(index);
                          model.deleteNews();
                        }
                      });
                    },

                    // child: Text("详情"))
                  ),
                  IconButton(
                      icon: Icon(model.newsList[index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        model.selectNews(index);
                        model.toggleFavorite();
                        model.notifyListeners();
                      })
                ],
                alignment: MainAxisAlignment.end,
              )
            ],
          ),
        );
      },
    );
  }
}
