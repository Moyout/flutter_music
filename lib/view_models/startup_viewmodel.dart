import 'dart:async';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/navigation_page.dart';
import 'package:flutter_music/widget/common/route_animation.dart';

class StartUpViewModel extends ChangeNotifier {
  Timer _timer;
  int times = 4; //秒数

  ///初始化ViewModel
  void initViewModel() {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    if (_timer == null)
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        times--;
        if (times == 0) {
          _timer.cancel();
          pushNewPage();
        }
        notifyListeners();
      });
  }

  void pushNewPage() {
    _timer?.cancel();
    RouteUtil.pushReplacement(CustomRoute(NavigationPage()));
  }
}
