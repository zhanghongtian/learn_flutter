import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(new MyRowWidgetApp());
}

class MyRowWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Row widget Demo",
        home: Scaffold(
            appBar: new AppBar(
              title: new Text("垂直方向布局"),
            ),
            body: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("I am zhanghongtian"),
                  Text("I am lilingling"),
                  Text("I am liyi"),
                  Text("I love coding"),
                ],
              ),
            )));
  }
}
