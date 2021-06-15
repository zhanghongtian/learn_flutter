import 'package:flutter/material.dart';

/**
 * 自定义的路由
 */
class CustomRoute<T> extends MaterialPageRoute<T> {
  /**
   * 只覆盖导航的动画效果
   */
  CustomRoute({WidgetBuilder widgetBuilder, RouteSettings routeSettings})
      : super(builder: widgetBuilder, settings: routeSettings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // return super.buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(
      opacity: CurvedAnimation(curve: Interval(0, 1, curve: Curves.easeOut), parent: super.controller),
      child: child,
    );
  }
}
