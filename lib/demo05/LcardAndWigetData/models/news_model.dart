import 'package:flutter/material.dart';

class NewsModel {
  final String id;
  final String title;
  final String description;
  final double score;
  final String imageUrl;
  final bool isFavorite; // 是否收藏
  final String userName;

  NewsModel(
      {@required this.title,
      this.id,
      this.description,
      this.score,
      this.imageUrl,
      this.isFavorite = false,
      this.userName}); // 命名参数的构造器，required修饰的参数代表是必填的
}
