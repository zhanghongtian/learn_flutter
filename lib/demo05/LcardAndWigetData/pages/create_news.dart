import 'package:flutter/material.dart';

/**
 * todo ctrl+alt 格式化代码
 * 知识点：
 * todo - 使用模态弹出层 showModalBottomSheet（翻译是显示底部的薄片）
 */
// class CreateNewsPagePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return Center(
//     //     child: ElevatedButton(
//     //   child: Text("创建资讯"),
//     //   onPressed: () {
//     //     showModalBottomSheet(
//     //         context: context,
//     //         builder: (context) {
//     //           return Column(
//     //             mainAxisAlignment: MainAxisAlignment.center,
//     //             crossAxisAlignment: CrossAxisAlignment.center,
//     //             children: [
//     //               Text("这是一个模态弹出层"),
//     //               TextButton(
//     //                   onPressed: () {
//     //                     Navigator.pop(context);
//     //                   },
//     //                   child: Text("确定"))
//     //             ],
//     //           );
//     //         });
//     //   },
//     // ));
//   }
// }

class CreateNewsPagePage extends StatefulWidget {
  final Function _addNews;
  final Function _deleteNews;

  CreateNewsPagePage(this._addNews, this._deleteNews);

  @override
  _CreateNewsPagePageState createState() => _CreateNewsPagePageState();
}

class _CreateNewsPagePageState extends State<CreateNewsPagePage> {
  String title = ''; // 资讯标题
  String description = ''; //资讯描述
  double score = 0.0; // 资讯分数
  bool _accept = false; // 接受条款

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width; // 获取屏幕的宽度
    double targetWidth =
        deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.8; // 最终的宽度
    double targetPadding = (deviceWidth - targetWidth) / 2; // 列表内边距
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: targetPadding),
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
                // 样式 设置TextField的样式
                labelText: '资讯标题'),
            onChanged: (String value) {
              setState(() {
                title = value;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(labelText: '资讯描述'),
            maxLines: 5, // 设置输入多行文本
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              setState(() {
                description = value;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(labelText: '资讯分数'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                score = double.parse(value);
              });
            },
          ),
        ),
        SwitchListTile(
            title: Text("接受条款"),
            value: _accept,
            onChanged: (value) {
              print(value);
              setState(() {
                _accept = value;
              });
            }),
        // ElevatedButton(
        //   onPressed: _submitForm,
        //   child: Text('创建'),
        // ),
        GestureDetector(
          // 自定义按钮
          onTap: _submitForm,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5.0) // border
                ),
            alignment: Alignment.center,
            height: 35,
            margin: EdgeInsets.fromLTRB((deviceWidth - deviceWidth * 0.4) / 2,
                5, (deviceWidth - deviceWidth * 0.4) / 2, 10),
            child: Text(
              '创建',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void _submitForm() {
    Map<String, String> news = {
      'title': title,
      "imageUrl": "assets/images/news01.png",
      'description': description,
      'score': score.toString()
    };
    widget._addNews(news);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
