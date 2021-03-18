import 'package:flutter_music/common/keys/public_keys.dart';
import 'package:flutter_music/util/tools.dart';

class SetViewModel extends ChangeNotifier {
  String status = "day_idle";
  bool isDark = false;
  bool listenCache = false;

  void initViewModel() {}

  Future<void> appInitSetting() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      isDark = SpUtil.getBool(PublicKeys.darkTheme) ?? false;
      !isDark ? status = dayIdle : status = nightIdle;
      listenCache = SpUtil.getBool(PublicKeys.darkTheme) ?? false;
      notifyListeners();
    });
  }

  Future<void> setThemeMode() async {
    if (status == dayIdle) {
      status = switchNight;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      status = nightIdle;
      isDark = true;
      notifyListeners();
      await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    } else if (status == nightIdle) {
      status = switchDay;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      status = dayIdle;
      isDark = false;
      notifyListeners();
      await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    }
  }

  Future<void> setListenAndSave() async {
    listenCache = !listenCache;
    await SpUtil.setBool(PublicKeys.listenCache, listenCache);
    notifyListeners();
  }
}
