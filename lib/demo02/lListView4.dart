import 'package:flutter/material.dart';

void main() => runApp(new MyListViewApp3(
    items: new List<String>.generate(100, (index) => "Item $index")));

class MyListViewApp3 extends StatelessWidget {
  final List items;
  MyListViewApp3({Key key, @required this.items}) : super(key: key);
  @override
  Widget build(Object context) {
    return MaterialApp(
      title: "动态传值",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("动态传递参数"),
        ),
        body: new Center(
          child: new Container(
            child: ListView.builder(
              itemCount: this.items.length,
              itemBuilder: (context, index) {
                return new ListTile(
                  title: new Text("${this.items[index]}"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
