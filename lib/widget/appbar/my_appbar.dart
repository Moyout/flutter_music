import 'package:flutter_music/util/tools.dart';

class MyAppBar extends AppBar {
  final Widget? title;
  final bool isShowLeading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final IconData? icon;

  MyAppBar({
    this.title,
    this.isShowLeading = true,
    this.actions,
    this.bottom,
    this.icon = Icons.arrow_back_outlined,
  }) : super(
          leading: isShowLeading
              ? MyElevatedButton(
                  () => RouteUtil.pop(AppUtils.getContext()),
                  icon,
                )
              : Container(),
          title: title,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: actions,
          bottom: bottom,
        );
}
