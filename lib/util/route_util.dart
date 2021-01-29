import 'package:flutter_music/util/tools.dart';

///路由
class RouteUtil {
  static void push(BuildContext context, Widget widget,
      {RouteAnimation animation}) {
    Navigator.push(context, CustomRoute(widget, routeAnimation: animation));
  }

  static void pop<T extends Object>(BuildContext context, [T result]) {
    Navigator.of(context).pop<T>(result);
  }

  static void pushReplacement(BuildContext context, Widget widget,
      {RouteAnimation animation}) {
    Navigator.pushReplacement(
        context, CustomRoute(widget, routeAnimation: animation));
  }
}
