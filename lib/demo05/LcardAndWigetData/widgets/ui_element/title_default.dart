import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;
  final double fontSize;

  TitleDefault(this.title, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10), // 外间距
      child: Text(
        title,
        softWrap: true, // 开启换行
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: this.fontSize),
      ),
    );
  }
}
