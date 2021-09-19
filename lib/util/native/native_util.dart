import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NativeUtil {
  //初始化通信管道-设置通道name
  static const String backToDesktopChannelName = "backToDesktopChannelName";

  //获取权限
  static Future<bool> backToDesktop() async {
    const MethodChannel platform = MethodChannel(backToDesktopChannelName);
    //通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('backToDesktop');
      if (out) debugPrint('返回桌面$out');
    } on PlatformException catch (e) {
      debugPrint("返回桌面( ${e.toString()})");
    }
    return Future.value(false);
  }
}
