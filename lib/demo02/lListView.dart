import 'package:flutter/material.dart';

void main() {
  runApp(new MyListViewApp());
}

class MyListViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ListView Widget ",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("ListView Widget"),
        ),
        body: new Center(
            child: new Container(
          child: new ListView(
            children: [
              new Image.network(
                  "https://pic.netbian.com/uploads/allimg/170704/232311-14991817912c74.jpg"),
              new Image.network(
                  "https://pic.netbian.com/uploads/allimg/210318/225732-16160794520c84.jpg"),
              new Image.network(
                  "https://pic.netbian.com/uploads/allimg/190902/152344-1567409024af8c.jpg"),
            ],
          ),
        )),
        bottomSheet: new BackButton(),
      ),
    );
  }
}
