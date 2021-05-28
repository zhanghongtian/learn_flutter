import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'news_card.dart';

/**
 * 知识点：
 * TODO -  如何把小部件拆分到单独的文件中，并且知道要怎么选择使用less和ful
 * todo -  ListView的使用
 */
class News extends StatelessWidget {
  // final List<NewsModel> news;
  // final Function deleteNews;

  // News({this.news, this.deleteNews});

  // todo ListView 使用方式1
  // @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //     child: ListView(
  //       children: news
  //           .map((e) => Card(
  //         child: Column(
  //           children: <Widget>[
  //             Image.asset("assets/images/news01.png",width: 400,height: 90),
  //             Text("卡片 $e")
  //           ],
  //         ),
  //       ))
  //           .toList(),
  //     ),
  //   );
  // }

  // todo ListView 使用方式2
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
        builder: (BuildContext context, Widget child, MainScopeModel model) {
          print(model.displayNews);
      return buildNewsList(
          model.displayNews, model.deleteNews, model.selectNews);
    });
  }

  Widget buildNewsList(
      List<NewsModel> news, Function deleteNews, Function selectNews) {
    if (news.length <= 0) {
      return Center(child: Text("暂无资讯"));
    } else {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return NewsCard(
              index: index,
            );
          },
          itemCount: news.length,
        ),
      );
    }
  }

  // Widget _buildNewsItem(BuildContext context, int index) {
  //   return Card(
  //     child: Column(
  //       children: <Widget>[
  //         Image.asset(news[index]['imageUrl'], width: 400, height: 90),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Flexible(
  //               fit: FlexFit.tight,
  //               flex: 15,
  //               child: Container(
  //                 margin: EdgeInsets.only(top: 10), // 外间距
  //                 child: Text("资讯" + news[index]['title']),
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Expanded(
  //               flex: 3,
  //               child: Score(news[index]['score'].toString()),
  //             ),
  //           ],
  //         ),
  //         ButtonBar(
  //           children: [
  //             IconButton(
  //               icon: Icon(Icons.favorite_border),
  //               onPressed: () {
  //                 // Navigator.push<bool>(context,
  //                 //     MaterialPageRoute(builder: (context) {
  //                 //   return NewsDetailPage(
  //                 //     title: news[index]['title'],
  //                 //     imageUrl: news[index]['imageUrl'],
  //                 //   );
  //                 // })).then((value) {
  //                 //   print(value);
  //                 //   if (value) {
  //                 //     deleteNews(index);
  //                 //   }
  //                 // });
  //                 Navigator.pushNamed(context, "/news/" + index.toString())
  //                     .then((value) {
  //                   print(value);
  //                   if (value) {
  //                     deleteNews(index);
  //                   }
  //                 });
  //               },
  //
  //               // child: Text("详情"))
  //             )
  //           ],
  //           alignment: MainAxisAlignment.end,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
