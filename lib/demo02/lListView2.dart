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
        appBar: new AppBar(title: new Text("ListView Widget")),
        body: new Center(
            child: new Container(
          child: new ListView(
            children: [
              new ListTile(
                leading: Icon(Icons.access_alarm),
                title: new Text("Flutter good"),
              ),
              new ListTile(
                leading: Icon(Icons.accessible),
                title: new Text("Flutter yes"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              ),
              new ListTile(
                leading: Icon(Icons.access_alarm_sharp),
                title: new Text("Flutter cool"),
              )
            ],
          ),
        )),
        bottomSheet: new BackButton(),
      ),
    );
  }
}
