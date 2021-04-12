import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(new MyImageApp());
}

class MyImageApp extends StatelessWidget {
  @override
  Widget build(Object context) {
    return new MaterialApp(
      title: 'Image Widget',
      home: Scaffold(
        appBar: new AppBar(title: new Text("Image Widget")),
        body: new Center(
          child: new Container(
            child: new Image.network(
              "https://pic.netbian.com/uploads/allimg/180128/112234-1517109754fad1.jpg",
              repeat: ImageRepeat.repeatY,
            ),
            width: 450,
            height: 900,
          ),
        ),
      ),
    );
  }
}
