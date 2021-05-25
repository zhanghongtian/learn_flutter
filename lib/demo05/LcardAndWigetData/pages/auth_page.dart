import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

// class AuthPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: Text("登录"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text("登录"),
//           onPressed: () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) {
//               // return NewsListPage();
//             }));
//           },
//         ),
//       ),
//     );
//   }
// }

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _username;
  String _password;
  bool _accept = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        double deviceWidth = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: AppBar(
              title: Text("登录"),
            ),
            body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.9), BlendMode.dstATop),
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/auth_backgroud.png'))),
                child: Center(
                    child: SingleChildScrollView(
                  child: Container(
                      width: deviceWidth > 768.0
                          ? 500.0
                          : deviceWidth *
                              0.8, // 如果屏幕大小大于768像素，就设置为500像素，否则使用屏幕宽度的百分之80
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                labelText: '用户名',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5)),
                            onChanged: (value) {
                              setState(() {
                                _username = value;
                              });
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: '密码',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5)),
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                          ),
                          SwitchListTile(
                              title: Text(
                                '接受条款',
                                style: TextStyle(fontSize: 15),
                              ),
                              value: _accept,
                              onChanged: (value) {
                                setState(() {
                                  _accept = value;
                                });
                              }),
                          ElevatedButton(
                              onPressed: () {
                                model.login(_username, _password);
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              child: Text('登录'))
                        ],
                      )),
                ))));
      },
    );
  }
}
