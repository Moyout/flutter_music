import 'dart:async';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/navigation_page.dart';

class StartUpViewModel extends ChangeNotifier {
  Timer? _timer;
  int times = 4; //秒数

  ///初始化ViewModel
  void initViewModel(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
        times--;
        if (times == 0) {
          _timer?.cancel();
          pushNewPage(context);
        }
        notifyListeners();
      });
  }

  void pushNewPage(BuildContext context) {
    _timer?.cancel();
    RouteUtil.pushReplacement(context,const NavigationPage());
  }
}
