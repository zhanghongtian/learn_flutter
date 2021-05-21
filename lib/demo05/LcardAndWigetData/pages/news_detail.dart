import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  NewsDetailPage({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: new AppBar(
            title: Text("详情"),
          ),
          body: Column(
              children: [
                Image.asset(imageUrl),
                Center(child: Text(title)),
                ElevatedButton(
                    onPressed: () => {Navigator.pop(context, true)},
                    child: Text("返回"))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center),
        ),
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false); // false 只弹出一个页面，true会继续弹出页面，直到没有页面弹出
        });
  }
}
