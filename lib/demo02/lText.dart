import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello world ZHT",
      home: Scaffold(
        appBar: new AppBar(title: new Text("hello world ZHT")), // 页面顶端导航栏
        body: new Center(
            child: new Text(
                "welcome my first flutter app，test Text widget ,我希望我可以自信，改变自己的懦弱",
                textAlign: TextAlign.center, // 文本对齐
                maxLines: 1, // 最大展示行 和 overflow 配合使用
                overflow: TextOverflow.ellipsis, // 超出限制展示
                style: new TextStyle(
                    fontSize: 20.0, // 文本大小
                    color: Color.fromARGB(255, 255, 125, 125), // 文本颜色
                    decoration: TextDecoration.underline, //文本装饰
                    decorationStyle: TextDecorationStyle.wavy))),
      ),
    );
  }
}
