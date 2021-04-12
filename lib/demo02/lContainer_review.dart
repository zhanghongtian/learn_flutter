import 'package:flutter/material.dart';

void main() {
  runApp(MyContainerApp());
}

class MyContainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ZHT的Container练习",
      home: Scaffold(
        appBar: new AppBar(title: new Text("AppBar")),
        body: Center(
          child: Container(
            child: new Text(
              "容器Container练习",
              style: new TextStyle(fontSize: 20),
            ),
            width: 450.0,
            height: 250.0,
            // color: Colors.lightBlue,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: new BoxDecoration(
                // color: Colors.lightGreen,
                gradient: new LinearGradient(colors: [
                  Colors.lightBlue,
                  Colors.white60,
                  Colors.blueGrey
                ]),
                border: Border.all(color: Colors.yellowAccent, width: 1)),
          ),
        ),
        backgroundColor: Colors.white70,
      ),
    );
  }
}
