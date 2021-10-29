import 'dart:async';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/navigation_page.dart';
import 'package:flutter_music/views/search_page/search_page.dart';
import 'package:quick_actions/quick_actions.dart';

class StartUpViewModel extends ChangeNotifier {
  late Timer _timer;
  int seconds = 4; //秒数
  String? shortcut;
  static const QuickActions quickActions = QuickActions();

  ///初始化ViewModel
  void initViewModel(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        _timer.cancel();
        pushNewPage(context);
      } else {
        seconds--;
      }

      notifyListeners();
    });
  }

  void pushNewPage(BuildContext context) {
    RouteUtil.pushReplacement(context, const NavigationPage());
  }

  void initQuickActions() {
    quickActions.initialize((String shortcutType) {
      Future.delayed(Duration(seconds: seconds + 1), () {
        RouteUtil.push(AppUtils.getContext(), const SearchPage());
        shortcut = shortcutType;
        notifyListeners();
        debugPrint("shortcut------------------------>$shortcut");
      });
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'action1', localizedTitle: '搜索歌曲', icon: 'launcher_icon'),
    ]);
    debugPrint("==================>${shortcut ?? "null"}");
  }
}
