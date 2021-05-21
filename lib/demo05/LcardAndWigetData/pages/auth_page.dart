import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/news_list.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("登录"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("登录"),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              // return NewsListPage();
            }));
          },
        ),
      ),
    );
  }
}
