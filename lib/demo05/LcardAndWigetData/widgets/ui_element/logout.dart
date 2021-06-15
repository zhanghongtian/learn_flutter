import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Logout extends StatelessWidget {
  const Logout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return ListTile(
          leading: Icon(
            Icons.logout,
            size: 20,
            color: Theme.of(context).shadowColor
          ),
          title: Text("退出"),
          onTap: () {
            model.logout();
            Navigator.pushReplacementNamed(context, '/');
          },
        );
      },
    );
  }
}
