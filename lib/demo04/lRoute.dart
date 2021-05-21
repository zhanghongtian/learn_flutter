import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      title: "父子页面跳转",
      home: Screen01(),
    ));

class Screen01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("父页面")),
      body: new Center(
        child: new Container(
            child: new ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Screen02()));
                },
                child: new Text("跳转子页面"))),
      ),
    );
  }
}

class Screen02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("子页面"),
      ),
      body: new Center(
        child: new Container(
          child: new ElevatedButton(
            child: new Text("返回父页面"),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
