import 'package:flutter/material.dart';

void main() => runApp(MyListViewApp2());

class MyListViewApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "横向ListView",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("横向ListView"),
        ),
        body: new Center(
          child: new Container(height: 600.0, child: new Mylist()),
        ),
      ),
    );
  }
}

class Mylist extends StatelessWidget {
  @override
  Widget build(Object context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: [
        new Container(
            width: 400.0,
            child: new Image.network(
              "https://up.enterdesk.com/edpic/a9/cc/1f/a9cc1fce10dc4b3bfb59969589bda9d0.jpg",
              fit: BoxFit.cover,
            )),
        new Container(
            width: 400.0,
            child: new Image.network(
              "https://img.cos56.com/caiji/5857/201712/0220/20171202200947_1562.jpg",
              fit: BoxFit.cover,
            )),
        new Container(
            width: 400.0,
            child: new Image.network(
              "https://th.bing.com/th/id/R147589f21f017c8b4460307df2170c72?rik=4HLolE8rM8mLDw&riu=http%3a%2f%2fwww.hues.com.cn%2fupfile%2fpic%2fimage%2f20180311%2f20180311084791539153.jpg&ehk=%2fxGcRC9z5KO%2fb1%2fTlE7cZ4Oc1cSGOMvKVCbwO9W%2bWWg%3d&risl=&pid=ImgRaw",
              fit: BoxFit.cover,
            )),
        new Container(
            width: 400.0,
            child: new Image.network(
              "https://th.bing.com/th/id/R3e66f98ddd7fbf7a9257ac288c89eccb?rik=SZo%2fFoLfepvdgA&riu=http%3a%2f%2f222.186.12.239%3a10010%2fwanmeiquxian_20181203%2f004.jpg&ehk=lvR6YeBEcPHJxXBE%2fpBOgbz7zTCX9ny9EhJyjgoCNGE%3d&risl=&pid=ImgRaw",
              fit: BoxFit.cover,
            )),
        new Container(
            width: 400.0,
            child: new Image.network(
              "https://th.bing.com/th/id/Re074e52fa7a35d205db60384d476bf5a?rik=oqQxlIHQYWf7xg&riu=http%3a%2f%2f222.186.12.239%3a10010%2faaxgaja_20181115%2f003.jpg&ehk=Kn91eoVRl84Rsa9Pq%2bVkvDvu68vVVY%2fdJf1%2b6fJ15%2b4%3d&risl=&pid=ImgRaw",
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}
