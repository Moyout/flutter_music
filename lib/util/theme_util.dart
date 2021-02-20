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
      iconTheme: IconThemeData(color: Colors.black),
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
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }
}
