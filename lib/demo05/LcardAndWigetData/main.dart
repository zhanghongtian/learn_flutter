import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app2/Ldart/day02.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/manage_news.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/pages/news_detail.dart';

import 'pages/news_list.dart';

/**
 * 知识点：
 * - TODO 怎么想Statefulwiget中传递数据，wiget关键字可以获取当前state对应的wiget中的属性 initState()方法在页面第一次展示部件的时候调用
 */
void main() {
  debugPaintPointersEnabled = false;
  debugPaintBaselinesEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  List<Map<String, String>> startNews = [];
  bool change = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _news = [];

  @override
  void initState() {
    /**
     * 这个方法在页面第一次使用这个小部件的时候调用
     */
    print("执行了initState");
    if (widget.startNews != null) {
      _news.addAll(widget.startNews);
    }
    super.initState();
  }

  void _addNews(Map news) {
    setState(() {
      _news.add(news);
    });
  }

  void _deleteNews(index) {
    setState(() {
      if (_news.length >= index) {
        _news.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/news': (context) {
        //   return NewsDetailPage(
        //     title: news[index]['title'],
        //     imageUrl: news[index]['imageUrl'],
        //   );
        // },
        '/admin': (context) {
          return ManagerNews();
        },
        '/': (context) {
          return NewsListPage(_news, _addNews, _deleteNews);
        }
      },
      debugShowMaterialGrid: false,
      // 显示网格，调试布局
      theme: ThemeData(
          brightness: Brightness.light, // 定义应用的主题
          primaryColor: Colors.deepOrange, // 定义主题的颜色
          accentColor: Colors.deepOrange[100], // 定义访问演示
          elevatedButtonTheme: ElevatedButtonThemeData(
              // 定义所有elevateButton按钮的主题
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)))),
      title: "封装Stateless并且传值",
      // home: AuthPage(),
      // body: ListView(
      //   children: [
      //     widget.change
      //         ? NewsManager(widget.startNews)
      //         : NewsManager(widget.startNews),
      //     ElevatedButton(
      //       onPressed: () {
      //         setState(() {
      //           widget.startNews = ['test'];
      //           widget.change = true;
      //         });
      //       },
      //       child: Text("改变stateFul外部数据"),
      //       // style: ButtonStyle(
      //       //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //       //   (Set<MaterialState> states) {
      //       //     if (states.contains(MaterialState.pressed))
      //       //       return Theme.of(context).primaryColor.withOpacity(0.5);
      //       //     return Theme.of(context)
      //       //         .primaryColor; // Use the component's default.
      //       //   },
      //       // )),
      //       // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange))
      //     )
      //   ],
      // )),
      onGenerateRoute: (RouteSettings settings) {
        print(settings.name);
        if (settings.name == '/') {
          return null;
        }
        var paths = settings.name.split("/");
        if (paths[0] != '') {
          return null;
        }
        if (paths[1] == 'news') {
          final index = int.parse(paths[2]);
          return MaterialPageRoute(builder: (context) {
            return NewsDetailPage(
                title: _news.length - 1 >= index ? _news[index]['title'] : '',
                imageUrl:
                    _news.length - 1 >= index ? _news[index]['imageUrl'] : '');
          });
        }
        // return MaterialPageRoute(builder: (context){
        //   return NewsDetailPage(
        //     title: news[index]['title'],
        //     imageUrl: news[index]['imageUrl'],
        //   );
        // });
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return NewsListPage(_news, _addNews, _deleteNews);
        });
      },
    );
  }
}
