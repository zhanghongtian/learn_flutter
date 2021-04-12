import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

void main(List<String> args) {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "底部导航栏 bottomNavigationBar",
      theme: ThemeData.light(),
      home: BottomNavigationWidget(),
    );
  }
}
