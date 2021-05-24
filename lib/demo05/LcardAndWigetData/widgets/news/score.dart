import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  String _score;

  Score(this._score);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0) // border
          ),
      child: Text(
        _score,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
