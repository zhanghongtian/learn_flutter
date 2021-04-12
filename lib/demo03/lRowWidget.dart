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
            title: new Text("水平方向布局"),
          ),
          body: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              new Expanded(
                  // 加上Expanded组件可以市按钮扩充，占满整个行
                  child: new RaisedButton(
                onPressed: () {},
                color: Colors.redAccent,
                child: new Text("Button"),
              )),
              new Expanded(
                  child: new RaisedButton(
                onPressed: () {},
                color: Colors.orangeAccent,
                child: new Text("Button"),
              )),
              new Expanded(
                  child: new RaisedButton(
                onPressed: () {},
                color: Colors.blueAccent,
                child: new Text("Button"),
              ))
            ],
          )),
    );
  }
}
