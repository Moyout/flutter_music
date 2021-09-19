import 'package:flutter_music/util/tools.dart';

class MyAppBar extends AppBar {
  @override
  final Widget? title;
  final bool isShowLeading;
  @override
  final List<Widget>? actions;
  @override
  final PreferredSizeWidget? bottom;
  final IconData? icon;

  MyAppBar({Key? key,
    this.title,
    this.isShowLeading = true,
    this.actions,
    this.bottom,
    this.icon = Icons.arrow_back_outlined,
  }) : super(key: key,
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
