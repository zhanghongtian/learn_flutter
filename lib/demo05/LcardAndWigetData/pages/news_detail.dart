import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/common.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/widgets/ui_element/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsDetailPage extends StatefulWidget {
  final int index;
  NewsDetailPage({Key key, this.index}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return WillPopScope(
            child: Scaffold(
              // appBar: new AppBar(
              //   title: Text("详情"),
              // ),
              // body: model.newsList.length > 0
              //     ? ListView(
              //         children: [
              //           Hero(
              //             //实现Hero的动画效果
              //             tag: model.newsList[widget.index].id,
              //             child: Image.network(CommonConfig.HOST +
              //                 model.newsList[widget.index].imageUrl),
              //           ),
              //           Center(
              //               child: TitleDefault(
              //                   model.newsList[widget.index].title, 20)),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Center(
              //               child:
              //                   Text(model.newsList[widget.index].description)),
              //           SizedBox(
              //             height: 50,
              //           )
              //           // Container(
              //           //     padding: EdgeInsets.symmetric(
              //           //         horizontal:
              //           //             (deviceWidth - deviceWidth * 0.2) / 2),
              //           //     child: ElevatedButton(
              //           //         onPressed: () {
              //           //           // Navigator.pop(context, true),
              //           //           _showDialogWarning(context);
              //           //           model.resetSelectedNews();
              //           //         },
              //           //         child: Text("返回")))
              //         ],
              //         // mainAxisAlignment: MainAxisAlignment.center,
              //         // crossAxisAlignment: CrossAxisAlignment.center
              //       )
              //     : Container(),
              body: CustomScrollView( // 自定义滚动效果 实现sliver效果
                slivers: [ // 滚动view中的小部件
                  SliverAppBar( // 导航栏
                    expandedHeight: 400,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar( // 顶部导航的标题
                        centerTitle: true,
                        background: Hero( // 导航栏的背景图片
                          tag: model.newsList[widget.index].id,
                          // 渐变图片
                          child: FadeInImage(
                            height: 400,
                            fit: BoxFit.cover, // 图片铺满展示
                            placeholder:
                                AssetImage(CommonConfig.PLACE_HOLDER), // 占位图片
                            image: NetworkImage(CommonConfig.HOST +
                                model.newsList[widget.index].imageUrl),
                          ),
                        ),
                        title: TitleDefault(
                            model.newsList[widget.index].title, 17)),
                  ),
                  SliverList( // 小部件列表
                      delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.fromLTRB(10,10,10,50),
                      child: Text(model.newsList[widget.index].description),
                    )
                  ])),
                ],
              ),
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: CurvedAnimation(
                        parent: _animationController, curve: Curves.easeOut),
                    child: FloatingActionButton(
                      heroTag: 'like',
                      mini: true,
                      backgroundColor: Colors.white,
                      child: Icon(
                          model.newsList[widget.index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Theme.of(context).accentColor),
                      onPressed: () {
                        model.selectNews(model.newsList[widget.index].id);
                        model.toggleFavorite();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ScaleTransition(
                    scale: CurvedAnimation(
                        parent: _animationController, curve: Curves.easeOut),
                    child: FloatingActionButton(
                      heroTag: 'email',
                      mini: true,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.email,
                          color: Theme.of(context).accentColor),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform(
                          alignment: FractionalOffset.center, // 居中显示图标
                          transform: Matrix4.rotationZ(
                              _animationController.value * 0.5 * pi),
                          child: Icon(Icons.more_vert, color: Colors.white),
                        );
                      },
                    ),
                    onPressed: () {
                      if (_animationController.isDismissed) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    },
                  )
                ],
              ),
            ),
            onWillPop: () {
              Navigator.pop(context, false);
              return Future.value(false); // false 只弹出一个页面，true会继续弹出页面，直到没有页面弹出
            });
      },
    );
  }
}

// class NewsDetailPage extends StatelessWidget {
//   final int index;
//   NewsDetailPage(this.index);
//   void _showDialogWarning(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("确定吗"),
//             content: Text("删除后不可以撤回"),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context); // 弹出页面 代表关闭对话框
//                     Navigator.pop(context, true); // 再次弹出页面，代表返回资讯列表，并且删除
//                   },
//                   child: Text("删除")),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context); // 弹出页面 代表关闭对话框
//                   },
//                   child: Text("取消"))
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MainScopeModel>(
//       builder: (context, child, model) {
//         double deviceWidth = MediaQuery.of(context).size.width; // 获取媒体介质的宽度
//         return WillPopScope(
//             child: Scaffold(
//               appBar: new AppBar(
//                 title: Text("详情"),
//               ),
//               body: model.newsList.length > 0
//                   ? ListView(
//                       children: [
//                         Image.network(
//                             CommonConfig.HOST + model.newsList[index].imageUrl),
//                         Center(
//                             child:
//                                 TitleDefault(model.newsList[index].title, 20)),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Center(child: Text(model.newsList[index].description)),
//                         SizedBox(
//                           height: 50,
//                         )
//                         // Container(
//                         //     padding: EdgeInsets.symmetric(
//                         //         horizontal:
//                         //             (deviceWidth - deviceWidth * 0.2) / 2),
//                         //     child: ElevatedButton(
//                         //         onPressed: () {
//                         //           // Navigator.pop(context, true),
//                         //           _showDialogWarning(context);
//                         //           model.resetSelectedNews();
//                         //         },
//                         //         child: Text("返回")))
//                       ],
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.center
//                     )
//                   : Container(),
//               floatingActionButton: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   FloatingActionButton(
//                     heroTag: 'like',
//                     mini: true,
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                         model.newsList[index].isFavorite
//                             ? Icons.favorite
//                             : Icons.favorite_border,
//                         color: Theme.of(context).accentColor),
//                     onPressed: () {
//                       model.selectNews(model.newsList[index].id);
//                       model.toggleFavorite();
//                     },
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   FloatingActionButton(
//                     heroTag: 'email',
//                     mini: true,
//                     backgroundColor: Colors.white,
//                     child:
//                         Icon(Icons.email, color: Theme.of(context).accentColor),
//                     onPressed: () {},
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   FloatingActionButton(
//                     backgroundColor: Theme.of(context).primaryColor,
//                     child: Icon(Icons.more_vert, color: Colors.white),
//                     onPressed: () {},
//                   )
//                 ],
//               ),
//             ),
//             onWillPop: () {
//               Navigator.pop(context, false);
//               return Future.value(false); // false 只弹出一个页面，true会继续弹出页面，直到没有页面弹出
//             });
//       },
//     );
//   }
// }
