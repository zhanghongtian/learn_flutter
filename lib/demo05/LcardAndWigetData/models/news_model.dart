import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class NewsModel{
  final String title;
  final String description;
  final double score;
  final String imageUrl;

  NewsModel({@required this.title, this.description, this.score, this.imageUrl}); // 命名参数的构造器，required修饰的参数代表是必填的
}