import 'package:flutter/material.dart';

/**
 * 知识点：
 * todo - 解除状态的特性，将有状态的小部件的状态提取出来有一个有状态的小部件来控制。
 */
class NewsControl extends StatelessWidget {
  Function addNews;

  NewsControl({
    this.addNews
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text("添加资讯"),
        onPressed: () {
          addNews({"title": "资讯第二个", "imageUrl": "assets/images/news01.png"});
        },
      ),
    );
  }
}
