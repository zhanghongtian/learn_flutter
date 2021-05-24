import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/news_scope_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

import 'score.dart';

class NewsCard extends StatelessWidget {
  final int index;

  const NewsCard({Key key, this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NewsScopeModel>(
      builder: (context, child, model) {
        model.selectNews(index);
        return Card(
          child: Column(
            children: <Widget>[
              Image.asset(model.selectedNews.imageUrl, width: 400, height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 15,
                      child: TitleDefault(model.selectedNews.title)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Score(model.selectedNews.score.toString()),
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
                              "/news/" + model.selectedIndex.toString())
                          .then((value) {
                        print(value);
                        if (value) {
                          model.deleteNews();
                        }
                      });
                    },

                    // child: Text("详情"))
                  )
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
