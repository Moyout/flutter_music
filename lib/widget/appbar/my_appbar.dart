import 'package:flutter_music/util/tools.dart';

class MyAppBar extends AppBar {
  final Widget? title;
  final bool isShowLeading;

  MyAppBar({this.title, this.isShowLeading = true})
      : super(
          leading: isShowLeading
              ? MyElevatedButton(() => RouteUtil.pop(AppUtils.getContext()),
                  Icons.arrow_back_outlined)
              : Container(),
          title: title,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        );
}
