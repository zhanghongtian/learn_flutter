import 'package:flutter/material.dart';

import 'bottom_appbar_demo.dart';

void main(List<String> args) {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "不规则底部导航栏",
      // 自定义一主题样本
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BottomAppBarDemo(),
    );
  }
}
