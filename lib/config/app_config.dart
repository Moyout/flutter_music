import 'package:flutter_music/util/sp_util.dart';
import 'package:flutter_music/util/tools.dart';

class AppConfig {
  /// 初始化持久化数据
  static Future<void> initSp() async {
    await SpUtil.getInstance();
  }


  ///错误widget
  static void errorWidget() {
    ///错误Widget
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Toast.showBottomToast(details.exception.toString());
      return Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "程序似乎崩溃了\n ${details.exception}",
                style: const TextStyle(fontFamily: ""),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: () {
                    ///todo:上报
                  },
                  child: const Text("上报日志"))
            ],
          ),
        ),
      );
    };
  }


  ///强制竖屏
  static void setPreferredOrientations(){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
