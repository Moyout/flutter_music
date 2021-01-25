import 'package:flutter_music/util/tools.dart';

///路由
class RouteUtil {
  static void push(CustomRoute customRoute) {
    Navigator.push(AppUtils.getContext(), customRoute);
  }

  static void pop<T extends Object>([T result]) {
    Navigator.of(AppUtils.getContext()).pop<T>(result);
  }

  static void pushReplacement(CustomRoute customRoute) {
    Navigator.pushReplacement(AppUtils.getContext(), customRoute);
  }
}
