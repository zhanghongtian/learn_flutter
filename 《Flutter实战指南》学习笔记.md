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



### 导航相关

Navigator [ˈnævɪɡeɪtə(r)] 导航器 用来实现页面之前的切换 数据结构是栈 方法push、pop。

WillPopScope 即将弹出的作用域

Replacement 替换、更换 Navigator的方法pushReplacement



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

