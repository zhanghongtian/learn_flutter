import 'package:flutter/material.dart';

/**
 *知识点：
 * todo - 使用自定的小部件
 */
import 'widgets/news/news.dart';

class NewsManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // NewsControl(addNews: _addNews),
        News()
      ],
    );
  }
}
