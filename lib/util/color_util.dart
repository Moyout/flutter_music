import 'package:flutter_music/util/tools.dart';

class ColorUtil {
  // static Color negationColor(Color oldColor) {
  //   print(oldColor);
  //   int white = Color(0xffffffff).value;
  //   int oldInt = oldColor.value;
  //   String hexadecimal = (white - oldInt).toRadixString(16);
  //   Color newColor = Color(int.parse("0xff" + hexadecimal));
  //   print(newColor);
  //   return newColor;
  // }
  static Color negationColor(Color oldColor) {
    Color newColor = Color.fromRGBO(
      255 - oldColor.red,
      255 - oldColor.green,
      255 - oldColor.blue,
      oldColor.opacity,
    );
    return newColor;
  }
}
