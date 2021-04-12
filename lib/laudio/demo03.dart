import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

///
/// 播放、录音
///
void main() {
  runApp(MaterialApp(
    home: MyRecorderApp(),
  ));
}

class MyRecorderApp extends StatefulWidget {
  @override
  _MyRecorderAppState createState() => _MyRecorderAppState();
}

class _MyRecorderAppState extends State<MyRecorderApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
