import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/title_default.dart';

import 'score.dart';

class NewsCard extends StatelessWidget {
  Map<String, String> news;
  int index;
  Function _deleteNews;

  NewsCard(this.news, this.index, this._deleteNews);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(news['imageUrl'], width: 400, height: 90),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 15,
                  child: TitleDefault(news['title'])),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Score(news['score'].toString()),
              ),
            ],
          ),
          ButtonBar(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
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
                      _deleteNews(index);
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
  }
}
