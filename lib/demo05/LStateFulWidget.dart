import 'package:flutter/material.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  String textStr = "ssss";

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "数据改变会重新调用build方法",
      home: Scaffold(
        appBar: AppBar(
          title: Text("数据改变重新调用build方法"),
        ),
        body: Center(
            child: Row(
          children: [
            Container(
              child: Text(textStr),
            ),
            Container(
              child: ElevatedButton(
                child: Text("改变值"),
                onPressed: () => {
                  setState(() {
                    textStr = "bbbbb";
                  })
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("改回来"),
                onPressed: () => {
                  setState(() {
                    textStr = "ssss";
                  })
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
