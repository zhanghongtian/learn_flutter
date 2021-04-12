import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(new MyRowWidgetApp());
}

class MyRowWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
      alignment: FractionalOffset(0.5, 0.85),
      children: [
        new CircleAvatar(
          backgroundImage: new NetworkImage(
              "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic4.zhimg.com%2F50%2Fv2-d2a17325b24040679897d9410d1e2664_hd.jpg&refer=http%3A%2F%2Fpic4.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619191445&t=1f58316b54b8f2f68708982bc5173cb2"),
          radius: 100,
        ),
        new Container(
          decoration: new BoxDecoration(color: Colors.lightGreen),
          child: new Text("是我太帅还是你太丑"),
        ),
        new Container(
          decoration: new BoxDecoration(color: Colors.lightGreen),
          child: new Text("总是看不上眼"),
        )
      ],
    );
    return new MaterialApp(
        title: "Row widget Demo",
        home: Scaffold(
            appBar: new AppBar(
              title: new Text("层叠布局"),
            ),
            body: new Center(child: stack)));
  }
}
