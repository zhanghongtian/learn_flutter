import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/image.dart';
import 'package:scoped_model/scoped_model.dart';

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

class EditNewsPage extends StatefulWidget {
  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  String title = ''; // 资讯标题
  String description = ''; //资讯描述
  double score = 0.0; // 资讯分数
  bool _accept = false; // 接受条款
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'title': null,
    'imageUrl': null,
    'description': null,
    'score': null
  };

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        Widget pageContent = _buildPageContent(context, model);
        return model.selectedNewsId == null
            ? Scaffold(
                body: pageContent,
              )
            : WillPopScope(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('编辑资讯'),
                  ),
                  body: pageContent,
                ),
                onWillPop: () {
                  model.resetSelectedNews();
                  Navigator.pop(context);
                  return Future.value(false);
                });
      },
    );
  }

  void _submitForm(MainScopeModel model) {
    if (!_formkey.currentState.validate()) {
      // 验证表单内容
      return;
    }
    _formkey.currentState.save();
    // Map<String, String> news = {
    //   'title': title,
    //   "imageUrl": "assets/images/news01.png",
    //   'description': description,
    //   'score': score.toString()
    // };
    if (_formData['imageUrl'] == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('资讯图片不能为空'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('确认')),
              ],
            );
          });
      return;
    }
    if (model.selectedNewsId == null) {
      model.addNews(_formData).then((bool isSuccess) {
        print("isSuccess");
        if (isSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('提醒'),
                  content: Text('服务端出错'),
                  actions: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('确认')),
                  ],
                );
              });
        }
      });
    } else {
      model
          .updateNews(_formData)
          .then((value) => Navigator.pushReplacementNamed(context, '/home'));
    }
  }

  Widget _buildPageContent(BuildContext context, MainScopeModel model) {
    double deviceWidth = MediaQuery.of(context).size.width; // 获取屏幕的宽度
    double targetWidth =
        deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.8; // 最终的宽度
    double targetPadding = (deviceWidth - targetWidth) / 2; // 列表内边距
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); // 获取焦点
        },
        child: Form(
            key: _formkey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding),
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: model.selectedNews == null
                        ? ''
                        : model.selectedNews.title.toString(),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        // 样式 设置TextField的样式
                        labelText: '资讯标题'),
                    // onChanged: (String value) {
                    //   setState(() {
                    //     title = value;
                    //   });
                    // },
                    validator: (String value) {
                      // 验证器
                      if (value.trim().length == 0 || value.length < 5) {
                        return '资讯标题不能为空,而且不能少于5个字';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      // setState(() {
                      _formData['title'] = value;
                      // });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: model.selectedNews == null
                        ? ''
                        : model.selectedNews.description.toString(),
                    decoration: InputDecoration(labelText: '资讯描述'),
                    maxLines: 5,
                    // 设置输入多行文本
                    keyboardType: TextInputType.text,
                    // onChanged: (String value) {
                    //   setState(() {
                    //     description = value;
                    //   });
                    // },
                    onSaved: (String value) {
                      // setState(() {
                      _formData['description'] = value;
                      // });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: model.selectedNews == null
                        ? ''
                        : model.selectedNews.score.toString(),
                    decoration: InputDecoration(labelText: '资讯分数'),
                    keyboardType: TextInputType.number,
                    // onChanged: (String value) {
                    //   setState(() {
                    //     score = double.parse(value);
                    //   });
                    // },
                    validator: (String value) {
                      if (value.isEmpty ||
                          !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                              .hasMatch(value)) {
                        return '不能为空并且必须是数字类型';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      // setState(() {
                      _formData['score'] = double.parse(value).toString();
                      // });
                    },
                  ),
                ),
                ImageInput(
                  setImage: this._setImage,
                  initImage: this._initImage,
                ),
                SwitchListTile(
                    title: Text("接受条款"),
                    value: _accept,
                    onChanged: (value) {
                      // print(value);
                      setState(() {
                        _accept = value;
                      });
                    }),
                // ElevatedButton(
                //   onPressed: _submitForm,
                //   child: Text('创建'),
                // ),
                _buildSubmitButton(deviceWidth)
              ],
            )));
  }

  Widget _buildSubmitButton(deviceWidth) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return model.isLoading
            ? Container(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : GestureDetector(
                // 自定义按钮
                onTap: () {
                  _submitForm(model);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5.0) // border
                      ),
                  alignment: Alignment.center,
                  height: 35,
                  margin: EdgeInsets.fromLTRB(
                      (deviceWidth - deviceWidth * 0.4) / 2,
                      5,
                      (deviceWidth - deviceWidth * 0.4) / 2,
                      10),
                  child: Text(
                    model.selectedNewsId != null ? '保存' : '创建',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
      },
    );
  }

  void _setImage(File file, MainScopeModel model) async {
    model.toggleLoading(true);
    String url = await model.uploadFile(file);
    if (null != url) {
      setState(() {
        _formData['imageUrl'] = url;
      });
    }
    model.toggleLoading(false);
  }

  void _initImage(String url) async {
    if (null != url) {
      setState(() {
        _formData['imageUrl'] = url;
      });
    }
  }
}
