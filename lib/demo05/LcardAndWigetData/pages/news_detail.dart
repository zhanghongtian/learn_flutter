import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/title_default.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  NewsDetailPage({this.title, this.imageUrl});

  void _showDialogWarning(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("确定吗"),
            content: Text("删除后不可以撤回"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); // 弹出页面 代表关闭对话框
                    Navigator.pop(context, true); // 再次弹出页面，代表返回资讯列表，并且删除
                  },
                  child: Text("删除")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); // 弹出页面 代表关闭对话框
                  },
                  child: Text("取消"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          appBar: new AppBar(
            title: Text("详情"),
          ),
          body: ListView(
            children: [
              Image.asset(imageUrl),
              Center(child: TitleDefault(title)),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: (deviceWidth - deviceWidth * 0.2) / 2),
                  child: ElevatedButton(
                      onPressed: () => {
                            // Navigator.pop(context, true),
                            _showDialogWarning(context)
                          },
                      child: Text("返回")))
            ],
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center
          ),
        ),
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false); // false 只弹出一个页面，true会继续弹出页面，直到没有页面弹出
        });
  }
}
