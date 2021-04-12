import 'package:flutter/material.dart';

class EachView extends StatefulWidget {
  final String _title;

  const EachView(this._title);

  @override
  _EachViewState createState() => _EachViewState();
}

class _EachViewState extends State<EachView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: new AppBar(
        title: new Text(widget._title),
      ),
      body: new Center(
        child: new Text(widget._title),
      ),
    );
  }
}
