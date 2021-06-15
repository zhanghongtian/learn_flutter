import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/min_model.dart';
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

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  AnimationController _animationController; // 动画控制器
  Animation<Offset> _slideAnimation; // 创建位置动画属性
  AuthMode _authMode = AuthMode.Login;
  Map<String, dynamic> _formData = {'username': Null, 'password': Null};
  bool _accept = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 500)); // vsync 表示挡圈组件是动作组件，duration 表示动画的持续时间
    _slideAnimation = Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0, 1, curve: Curves.fastOutSlowIn)));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode()); // 获取焦点
          },
          child: Form(
            key: _formKey,
            child: Scaffold(
                appBar: AppBar(
                  title: Text("登录"),
                ),
                body: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.9),
                                BlendMode.dstATop),
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/images/auth_backgroud.png'))),
                    child: Center(
                        child: SingleChildScrollView(
                      child: Container(
                          width: deviceWidth > 768.0
                              ? 500.0
                              : deviceWidth *
                                  0.8, // 如果屏幕大小大于768像素，就设置为500像素，否则使用屏幕宽度的百分之80
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: '用户名',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.5)),
                                // onChanged: (value) {
                                //   setState(() {
                                //     _username = value;
                                //   });
                                // },
                                validator: (String value) {
                                  if (value.trim().length == 0) {
                                    return '用户名不能为空';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _formData['username'] = value;
                                },
                              ),
                              TextFormField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      labelText: '密码',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.5)),
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _password = value;
                                  //   });
                                  // },
                                  validator: (String value) {
                                    if (value.trim().length == 0) {
                                      return '密码不能为空';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _formData['password'] = value;
                                  }),
                              _authMode == AuthMode.Singup
                                  // 渐变动画 FadeTransition
                                  ? SlideTransition(
                                      // opacity: CurvedAnimation(
                                      //     parent: _animationController,
                                      //     curve: Interval(0, 1,
                                      //         curve: Curves.easeIn)),
                                      position: _slideAnimation,
                                      child: TextFormField(
                                        obscureText: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                            labelText: '确认',
                                            filled: true,
                                            fillColor:
                                                Colors.white.withOpacity(0.5)),
                                        // onChanged: (value) {
                                        //   setState(() {
                                        //     _password = value;
                                        //   });
                                        // },
                                        onSaved: (value) {
                                          _formData['password'] = value;
                                        },
                                        validator: (String value) {
                                          if (_passwordController.text !=
                                              value) {
                                            return '两次密码输入不一致';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  : Container(),
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
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_authMode == AuthMode.Login) {
                                        _authMode = AuthMode.Singup;
                                        _animationController.forward();
                                      } else {
                                        _authMode = AuthMode.Login;
                                        _animationController.reverse();
                                      }
                                    });
                                  },
                                  child: Text(
                                      '切换到${_authMode == AuthMode.Login ? '注册' : '登录'}')),
                              model.isLoading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        submit(model);
                                      },
                                      child: Text(
                                          '${_authMode == AuthMode.Login ? '登录' : '注册'}'))
                            ],
                          )),
                    )))),
          ),
        );
      },
    );
  }

  void submit(MainScopeModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> response;
    if (_authMode == AuthMode.Login) {
      response =
          await model.login(_formData['username'], _formData['password']);
    } else {
      response =
          await model.singup(_formData['username'], _formData['password']);
    }
    if (response['success']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("提示信息"),
              content: Text(response['massage']),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("确定"))
              ],
            );
          });
    }
  }
}
