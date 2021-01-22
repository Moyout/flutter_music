import 'package:flutter_music/util/sp_util.dart';

class AppConfig {
  /// 初始化持久化数据
  static Future<void> initSp() async {
    await SpUtil.getInstance();
  }
}
