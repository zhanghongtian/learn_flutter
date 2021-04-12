import 'package:flutter/material.dart';

import 'each_view.dart';

class BottomAppBarDemo extends StatefulWidget {
  BottomAppBarDemo({Key key}) : super(key: key);

  @override
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
  List<Widget> _eachView = [];
  int _index = 0;

  @override
  void initState() {
    _eachView
      ..add(EachView("Home"))
      ..add(EachView("Email"))
      ..add(EachView("About"))
      ..add(EachView("Other"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: _eachView[_index],
      //定义一个浮点按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return new EachView("New Page");
          }));
        }, // 点击实践
        tooltip: "ZHT", // 提示，长按显示
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      // 浮点按钮的位置设定
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 底部按钮导航栏
      bottomNavigationBar: BottomAppBar(
        //工具栏
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                }),
            IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                }),
            IconButton(
                icon: Icon(Icons.cached),
                onPressed: () {
                  setState(() {
                    _index = 2;
                  });
                }),
            IconButton(
                icon: Icon(Icons.airline_seat_flat),
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                })
          ],
        ),
      ),
    );
  }
}
