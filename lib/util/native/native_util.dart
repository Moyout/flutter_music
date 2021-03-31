import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NativeUtil {
  //初始化通信管道-设置通道name
  static const String CHANNEL = "android/permission";

  //获取权限
  static Future<bool> getPermission() async {
    final platform = MethodChannel(CHANNEL);
    //通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('checkPermission');
      if (out) debugPrint('获取$out');
    } on PlatformException catch (e) {
      print("通信失败( )");
      print(e.toString());
    }
    return Future.value(false);
  }
}
