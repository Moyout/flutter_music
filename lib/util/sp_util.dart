import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///存储String
  static Future<bool> setString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }

  ///存储bool
  static Future<bool> setBool(String key, bool value) {
    if (_prefs == null) return null;
    return _prefs.setBool(key, value);
  }

  ///获取String
  static String getString(String key) {
    if (_prefs == null) return null;
    String status = _prefs.getString(key);
    if (status == null) return "";
    return status;
  }
  ///获取value
  static dynamic getValue(String key) {
    if (_prefs == null) return null;
    return _prefs.get(key);
  }

  ///获取所有key
  static Set<String> getKeys() {
    if (_prefs == null) return null;
    return _prefs.getKeys();
  }
}
