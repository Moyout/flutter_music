import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';

class AppUtils {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // 获取全局context
  static BuildContext getContext() {
    return AppUtils.navigatorKey.currentState!.overlay!.context;
  }

  // 关闭软键盘
  // static void turnOffKeyBoard() {
  //   FocusScope.of(getContext()).requestFocus(FocusNode());
  // }

  //获取屏幕宽度
  static double getWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }

  //获取屏幕高度
  static double getHeight() {
    return MediaQueryData.fromWindow(window).size.height;
  }
}
