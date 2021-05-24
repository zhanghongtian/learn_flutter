## Dart语言



> 强类型，静态类型的语言。Js是动态类型的语言。面向对象的语言。
>
> JIT：即时编译，开发期间，更快编译，更快的重载。
>
> AOT：事前编译，release期间，更快更流畅。



#### AndoridStudio快捷键

option+Enter 补全导包



#### 关键字

##### Final 和 const的区别和相同点

final修饰的变量的值只能被设置一次，使用过程中不可以被修改。final修饰的属性不可以使用等号重新赋值，但是可以改变他内部的数据。

Const修饰的变量必须被复制，因为Const修饰的变量在编译的时候就已经固定。在使用过程中也不能被修改。

区别：

声明变量的时候有不同，Final声明时可以初始化，Const声明时必须初始化。

初始化的时机有不同，final是在第一次使用的时候被初始化，const是在编译的时候就初始化。

final修饰的属性不可以重新使用等号赋值但是可以改变他内部的数据，const修饰的属性是常量，不可以重新赋值，也不可以调用他的方法修改内部的数据。

相同点：

被final和const修饰的变量在使用的时候都不可以修改。



## 常用英语单词

### 布局相关

alignment [əˈlaɪnmənt] 对齐

MainAxisAlignment 主轴对齐

crossAxisAlignment 横轴对齐

Row 行

Column 列

Expanded 扩展，扩充内存，扩充，扩大

Flexible 灵活的、可变动的、柔韧的、有弹性的、可弯曲的

Media 介质、媒体，在这里指手机、或者平板，大众传播工具

MediaQuery 查看媒体介质的参数

EdgeInsets 边缘集

symmetric 对称的

horizontal 水平的





### 导航相关

Navigator [ˈnævɪɡeɪtə(r)] 导航器 用来实现页面之前的切换 数据结构是栈 方法push、pop。

WillPopScope 即将弹出的作用域

Replacement 替换、更换 Navigator的方法pushReplacement

### 样式相关

border 边界

Radius 半径

borderRadius 边界半径，配置圆边角

circular 圆形的

cover 遮盖、盖、撒上、洒上、罩子、封皮

mode 方式、风格、样式、模式

Opacity 不透明度

Blend 混合、使混合、融合

BlendMode 混合模式

fillColor 填充的颜色

filled 是否填满

favorite 最喜欢的[在Icons中表示心型]

border 边界、镶边、沿..的边





## Flutter和dart的关联

![image-20210518201328832](/Users/zhanghongtian/Library/Application Support/typora-user-images/image-20210518201328832.png)



## Flutter小部件

### StatelessWidget

### StatefulWidget



## StatelessWidget的生命周期

当外部数据发生变化的时候，会重新调用的build方法。

![image-20210518182949303](/Users/zhanghongtian/Library/Application Support/typora-user-images/image-20210518182949303.png)

## StatefulWidget的生命周期

![image-20210518183748207](/Users/zhanghongtian/Library/Application Support/typora-user-images/image-20210518183748207.png)





## Material Design设计系统

### 修改MaterialApp的主题(theme)

代码示例：

```dart
return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, // 定义应用的主题
          primaryColor: Colors.deepOrange,  // 定义主题的颜色
          accentColor: Colors.deepOrange[100], // 定义访问演示
      		elevatedButtonTheme: ElevatedButtonThemeData( // 定义
            style: ButtonStyle(backgroundColor: 		
                               MaterialStateProperty.all(Colors.deepOrange))
          )),
      ), 
      title: "封装Stateless并且传值",
      home: Scaffold(
          appBar: AppBar(
            title: Text("传值"),
          ),
          body: Container()
      ),
    );
```



## Flutter中解除状态的特性

解释：

​		解除状态意思是把所有跟状态有关系的小部件的状态提取出来，放到一个有状态的小部件中，然后通过一个有状态的小部件去控制所有被提取状态的小部件。被提取状态的小部件是一个statelessWidget。



## ListView小部件

### 使用方式一 

​	适合长度比较少的

```dart
ListView(
        children: news
            .map((e) => Card(
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/news01.png",width: 400,height: 90),
              Text("卡片 $e")
            ],
          ),
        )).toList(),
)
```



### 使用方式一 

​	适合长度比较多的 只渲染可以看到的小部件，会自动删除移除屏幕外的小部件，所以性能比较好

```dart
	// 动态创建高性能和列表
	ListView.builder(itemBuilder: _buildNewsItem,itemCount: news.length,)


  Widget _buildNewsItem(BuildContext context, int index) {
    return Card(
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/images/news01.png",width: 400,height: 90),
                    Text("咨询"+news[index])
                  ],
                ),
              );
  }
  
```

_buildNewsItem 是一个函数

itemCount 是明细的长度

_buildNewsItem 方法中的参数context是上下文，index是下标，对应news的下标



## 页面导航

### ButtonBar按钮栏

### Navigator导航器

使用方式

```dart
// 添加一个新页面
Navigator.push(context,MaterialPageRoute(builder: (context) {
                 return NewsDetailPage();
								})
);
// 返回上一个页面
Navigator.pop(context);
```

#### push给页面传参

```dart
Navigator.push(context,
               MaterialPageRoute(builder: (context) {
                 return NewsDetailPage(
                   title: news[index]['title'],
                   imageUrl: news[index]['imageUrl'],
                 );
               }))
```

#### pop给页面传参

```dart
// 传参
Navigator.pop(context,true)
// 获取
Navigator.push<bool>(context,
					MaterialPageRoute(builder: (context) {
								return NewsDetailPage(
											title: news[index]['title'],
											imageUrl: news[index]['imageUrl'],
								);
					})).then((value) => {
								if (value) {deleteNews(index)}
									});
```

#### 捕捉导航页面中的点击事件

```dart
    // 需要使用WillPopScope在即将执行pop操作的时候生效，onWillPop方法写具体的逻辑
    return WillPopScope(
        child: Scaffold(
          appBar: new AppBar(
            title: Text("详情"),
          ),
          body: Column(
              children: [
                Image.asset(imageUrl),
                Center(child: Text("咨询详情页")),
                ElevatedButton(
                    onPressed: () => {Navigator.pop(context, true)},
                    child: Text("返回"))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center),
        ),
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(true); // false 只弹出一个页面，true会继续弹出页面，直到没有页面弹出
        });
```



### 抽屉式导航Drawer

使用方式

```dart
    return Scaffold(
      drawer: Drawer(    // 抽屉式导航
        child: Column(
          children: [
            AppBar(
              title: Text("选择"),
              automaticallyImplyLeading: false, //代表隐藏导航标题左侧的小图标
            ),
            ListTile(
              title: Text("管理咨询"),
              onTap: () {
                Navigator.pushReplacement(context,   //替换上一个添加的页面
                    MaterialPageRoute(builder: (context) {
                  return ManagerNews();
                }));
              },
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: Text("资讯标题"),
      ),
      body: NewsManager(),
    );
```



### Tab标签页导航

需要使用的几个主要小部件

- DefaultTabController
- TabBar
- Tab
- TabBarView

小部件的组合实现，要注意三点

- 页面需要使用DefaultTabController小部件包起来，并且配置length（tab的个数）
- 在Scaffold中的appBar中设置TabBar
- Scaffold中的body配置TabBarView,其中children的长度不能超过DefaultTabController配置的length

使用示例

```dart
    return DefaultTabController( //最外层
        length: 2,
        child: Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  AppBar(
                    title: Text("选择"),
                  ),
                  ListTile(
                    title: Text("咨询列表"),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return NewsListPage();
                      }));
                    },
                  )
                ],
              ),
            ),
            appBar: new AppBar(
              title: Text("管理咨询"),
              bottom: TabBar( // 必须是Scaffold中的AppBar中的bottom参数，表示是Appbar的底部
                tabs: [
                  Tab(
                    text: "创建资讯",
                    icon: Icon(Icons.create),
                  ),
                  Tab(
                    text: "我的资讯",
                    icon: Icon(Icons.edit),
                  )
                ],
              ),
            ),
            body: TabBarView( // tab切换要展示的内容
              children: [CreateNewsPagePage(), MyNews()], // 数量要和DefaultTabController的length属性对应
            )));
```



### 命名路径的方式导航

优点

- 解决每次使用MaterialPageRoute的繁琐

使用示例

- 配置路由注册表

```dart
    return MaterialApp(
      routes: { // 配置routes属性，相当于一个map，可以把所有的页面都在这里配置好映射
        '/admin': (context) {
          return ManagerNews();
        },
        '/': (context) { // 如果配置了'/',就相当于是配置了MaterialApp中的home属性，所有home属性不需要配置
          return AuthPage();
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
      // home: AuthPage(), // 配置了'/'所有注释掉
    );
```

- 使用路径导航

```dart
    return Scaffold(
      drawer: Drawer(
        // 抽屉式导航
        child: Column(
          children: [
            AppBar(
              title: Text("选择"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Text("管理咨询"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin'); // 使用命名路径导航
              },
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: Text("资讯标题"),
      ),
      body: NewsManager(),
    );
```

### 解析导航路径数据

指的是获取跳转路径中的值

例如：/news/10的路径，可以解析获取到路径中的10

配置MaterialApp小部件的中onGenerateRoute

配置示例

```dart
      onGenerateRoute: (RouteSettings settings) { //在生成页面路由的时候调用
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
          print("new_index:" + index.toString());
          return MaterialPageRoute(builder: (context) {
            return NewsDetailPage(
                title: _news.length - 1 >= index ? _news[index]['title'] : '',
                imageUrl: _news.length - 1 >= index
                    ? _news[index]['imageUrl']
                    : 'assets/images/news01.png');
          });
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) { // 如果没有的匹配到任何路由的时候调用在此配置的路由
        return MaterialPageRoute(builder: (context) {
          return NewsListPage(_news, _addNews, _deleteNews);
        });
      },
```



调用示例

```dart
 Navigator.pushNamed(context, "/news/" + index.toString())
```



### 对话框

需要配合使用的小部件

- showDialog 
- AlterDialog
  - AlterDialog中的属性actions可以自定义动作，比如按钮

使用示例

```dart
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("确定吗"),
        content: Text("删除后不可以撤回"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);// 弹出页面 代表关闭对话框
            Navigator.pop(context,true); // 再次弹出页面，代表返回资讯列表，并且删除
          }, child: Text("删除")),
          TextButton(onPressed: (){
            Navigator.pop(context);// 弹出页面 代表关闭对话框
          }, child: Text("取消"))
        ],
      );
    });
```

### 模态弹出层

需要配合使用的小部件

- showModalBottomSheet
  - 注意参数1必须是context
  - 参数二 builder 返回一个小部件

使用示例

```dart
    return Center(
        child: ElevatedButton(
      child: Text("创建资讯"),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("这是一个模态弹出层"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("确定"))
                ],
              );
            });
      },
    ));
```





## 处理用户的输入

### TextField输入框

使用示例一

```dart
TextField(
            decoration: InputDecoration( // 配置样式 设置TextField的样式、设置标签内容
                labelText: '资讯标题'),
            onChanged: (String value) {
              setState(() {
                title = value;
              });
            },
          )
```

使用示例二

```dart
 TextField(
            decoration: InputDecoration(labelText: '资讯描述'), // 配置样式 设置TextField的样式、设置标签内容
            maxLines: 5, // 设置输入多行文本
            keyboardType: TextInputType.text, // 设置键盘类型，配置文本输入类型
            onChanged: (String value) {
              setState(() {
                description = value;
              });
            },
          ),
```

### Switch开关

使用示例

```dart
        SwitchListTile( 
            title: Text("接受条款"), // 可以设置标题
            value: _accept, // 小部件的值 只有true或者false
            onChanged: (value) {
              print(value);
              setState(() {
                _accept = value;
              });
            }),
```



## 深入学习小部件

官网地址：https://flutter.dev/docs/development/ui/widgets

不同的小部件可以完成同一个目标，所以主要了解小部件有哪些特性。

### SizedBox占位小部件

描述：占位的作用，什么也不展示

属性：height、width

### DecoratedBox修饰小部件

描述：主要是样式修饰，例如添加背景色 ，边框、圆边角、以及颜色、阴影效果等。但是不可以设置亮度、对齐方式或者添加边距。

属性：decoration

建议：可以使用的Container代替，因为Container也可以配置decoration，并且可以设置亮度、对齐方式或添加边距。

### Expanded扩充小部件和Flexible弹性小部件

#### Expanded扩充小部件

描述：尽可能的占用剩余的空间，

#### Flexible弹性小部件

描述：不是使用的所有的空间，但可以设置fit属性来配置

#### 注意

Flexible和Expanded必须在行和列中使用，Expanded使用的所有的空间，Flexible也可以使用所有的空间，但是需要配置。两者都包括flex参数，flex参数表示按照比例分配空间。

### 

### BoxDecoration设置背景图片

示例：

```dart
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/auth_backgroud.png'))),
```



### MediaQuery媒体查询小部件

描述：通过此部件可以获取到当前媒体介质的屏幕属性（方向、宽度、高度）

示例：

```dart
 double deviceWidth = MediaQuery.of(context).size.width; // 获取屏幕的宽度
```



### GestureDetector手势识别小部件

描述：通过此部件可以写自定义按钮，也可以给任何小部件添加事件监听。

示例：自定义按钮(添加单击事件监听)

```dart
        GestureDetector( // 自定义按钮
          onTap: _submitForm,
          child: Container(
            padding: EdgeInsets.all(5.0),
            color: Theme.of(context).primaryColor,
            child: Text('创建'),
          ),
        )
```









## 遇到的问题

### Flutter项目在IOS设备上运行

#### pop install很慢或者卡主

##### 设置国内镜像

- 第一步

  ```
  cd ~/.cocoapods/repos
  pop repo remove master
  git clone https://gitee.com/mirrors/CocoaPods-Specs.git master
  ```

- 第二步 在项目的ios目录中的Podfile文件中第一行添加

  ```
  source 'https://gitee.com/mirrors/CocoaPods-Specs.git'
  ```

