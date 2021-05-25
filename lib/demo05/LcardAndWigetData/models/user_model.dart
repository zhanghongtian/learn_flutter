import 'package:flutter/material.dart';

/**
 * 用户模型
 */
class UserModel {
  String id;
  String userName;
  String password;
  UserModel(
      {@required this.id, @required this.userName, @required this.password});
}
