import 'package:flutter/material.dart';

/**
 * 用户模型
 */
class UserModel {
  String id;
  String userName;
  String password;
  String token;
  UserModel(
      {@required this.id,
      @required this.userName,
      this.password,
      @required this.token});
}
