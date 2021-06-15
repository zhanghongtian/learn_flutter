import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/common.dart';
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
              Hero(
                  tag: model.newsList[index].id,
                  child: FadeInImage(
                    placeholder: AssetImage(CommonConfig.PLACE_HOLDER),
                    image: NetworkImage(
                        CommonConfig.HOST + model.newsList[index].imageUrl),
                    height: 300,
                    fit: BoxFit.cover,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 15,
                      child: TitleDefault(model.newsList[index].title, 15)),
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
                  IconButton(
                    icon: Icon(Icons.info),
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
                      Navigator.pushNamed(context, "/news/" + index.toString())
                          .then((value) {
                        print(value);
                        if (value) {
                          model.selectNews(model.newsList[index].id);
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
                        print(model.newsList);
                        print(index);
                        model.selectNews(model.newsList[index].id);
                        model.toggleFavorite();
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
