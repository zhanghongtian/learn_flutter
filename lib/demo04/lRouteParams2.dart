import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "页面跳转返回数据",
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("找小姐姐要电话"),
      ),
      body: Center(
        child: new RouteButton(),
      ),
    );
  }
}

class RouteButton extends StatelessWidget {
  const RouteButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateToXiaoJieJie(context);
      },
      child: new Text("去找小姐姐"),
    );
  }

  _navigateToXiaoJieJie(BuildContext context) async {
    final result = await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new XiaoJieJie()));
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("我要找: $result")));
  }
}

class XiaoJieJie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("我是小姐姐"),
      ),
      body: Center(
        child: new Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, '大长腿小姐姐：12256347892');
              },
              child: new Text("大长腿小姐姐"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, '小蛮腰小姐姐：19823347777');
              },
              child: new Text("小蛮腰小姐姐"),
            ),
          ],
        ),
      ),
    );
  }
}
