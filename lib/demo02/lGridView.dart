import 'package:flutter/material.dart';

void main() => runApp(new MyGridViewApp());

class MyGridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "GridView学习",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("GridView学习"),
        ),
        body: new Center(
          child: new Container(
            padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: new GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //横向容纳的数量
                mainAxisSpacing: 2, //纵向间距
                crossAxisSpacing: 2, //横向间距
                childAspectRatio: 0.7, //子组件的比例 宽/高
              ),
              children: [
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/13/093605.61422332_180X260X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/07/092515.55805319_180X260X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/17/162028.94879602_135X190X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/19/165350.52237320_135X190X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/16/115256.24365160_180X260X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2018/11/20/141608.71613590_135X190X4.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/01/23/152040.68492869_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/03/16/171735.91038753_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/02/23/094533.66174685_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2020/12/11/070448.94524859_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2020/10/28/171548.59724664_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/03/04/085741.95756184_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/03/02/094542.13665952_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/01/14/171440.82380644_1280X720X2.jpg',
                    fit: BoxFit.cover),
                new Image.network(
                    'https://img5.mtime.cn/mt/2021/03/19/094328.66012450_1280X720X2.jpg',
                    fit: BoxFit.cover),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
