import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(new MyCardWidgetApp());
}

class MyCardWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card = new Card(
      child: new Column(
        children: [
          new ListTile(
            title: Text(
              "北京市天通苑小区",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("ZHT: 17535243716"),
            leading: Icon(
              Icons.account_box,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(),
          new ListTile(
            title: Text(
              "北京市朝阳区凯旋城",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("CJYD: 1853524876"),
            leading: Icon(
              Icons.account_box,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(),
          new ListTile(
            title: Text(
              "北京市宋家庄",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("老潘: 1053524386"),
            leading: Icon(
              Icons.account_box,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(),
          new ListTile(
            title: Text(
              "北京市成寿寺",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("珊珊: 13435243886"),
            leading: Icon(
              Icons.account_box,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(),
        ],
      ),
    );
    return MaterialApp(
      title: "卡片布局",
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("卡片布局"),
        ),
        body: new Center(
          child: card,
        ),
      ),
    );
  }
}
