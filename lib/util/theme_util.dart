import 'dart:ui';

import 'package:flutter_music/util/tools.dart';

class ThemeUtil {
  ///日间模式
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: "FZKT",
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
          fontFamily: "FZKT",
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      dividerColor: Colors.blueGrey,
      brightness: Brightness.light,
    );
  }

  ///深夜模式
  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "FZKT",
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.blueGrey,
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
          fontFamily: "FZKT",
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.white,
      brightness: Brightness.dark,
      dialogTheme: const DialogTheme(),

      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.all(Colors.blue),
      //     textStyle: MaterialStateProperty.all(
      //       TextStyle(color: Colors.red, fontSize: 14.sp,fontFamily: "FZKT"),
      //     ),
      //   ),
      // ),
    );
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color scaffoldColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Brightness brightness(BuildContext context) {
    return Theme.of(context).brightness;
  }
}
