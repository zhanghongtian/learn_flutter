import 'package:flutter/material.dart';
import 'package:flutter_app2/examples01/pages/email_screen.dart';
import 'package:flutter_app2/examples01/pages/home_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  BottomNavigationWidget({Key key}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _BottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = [];
  @override
  void initState() {
    list..add(HomeScreen())..add(EmailScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: list[_currentIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                  color: _BottomNavigationColor,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.airplay,
                  color: _BottomNavigationColor,
                ),
                label: "Email"),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
