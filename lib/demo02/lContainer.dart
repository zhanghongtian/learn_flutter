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
          child: new Container(
            child: new Text(
              "快",
              style: new TextStyle(fontSize: 25.0),
            ),
            alignment: Alignment.topCenter, // 对齐方式
            width: 500.0,
            height: 400.0,
            // color: Colors.lightBlue, // 天蓝色
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50), // 填充 （容器内边界设置）
            margin: const EdgeInsets.all(2), //容器的外边界设置
            decoration: new BoxDecoration(
                // 装饰 盒子装饰
                gradient: const LinearGradient(colors: [
                  // 梯度 线性梯度 实现渐变色
                  // 此属性需要注释掉color属性，要不然会报错
                  Colors.lightGreen,
                  Colors.limeAccent,
                  Colors.redAccent,
                ]),
                border: Border.all(width: 2, color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
