import 'package:flutter_music/util/tools.dart';

class KeyboardUtil {
  static void closeKeyboardUtil() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }
}
