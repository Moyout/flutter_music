import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Toast {
  //toast提示
  static showBotToast(String text, {int seconds = 3}) {
    return BotToast.showSimpleNotification(

      title: text,
      hideCloseButton: true,
      duration: Duration(seconds: seconds),
    );
  }

  static showBottomToast(String text, {Alignment? alignment = const Alignment(0, 0.8)}) {
    return BotToast.showText(
      text: text,
      align: alignment,
//      contentColor: Colors.white,
//      backgroundColor: Colors.grey
    );
  }

  static showOnTap(String text, {Offset offset = Offset.zero}) {

    return BotToast.showText(
      text: text,
      align: Alignment(offset.dx / MediaQuery.of(AppUtils.getContext()).size.width,
          offset.dy / MediaQuery.of(AppUtils.getContext()).size.height),
    );
  }

  static showLoadingToast({int seconds = 1, bool clickClose = true}) {
    return BotToast.showLoading(
      duration: Duration(seconds: seconds),
      clickClose: clickClose,
      crossPage: false,
      backButtonBehavior: BackButtonBehavior.ignore, //拦截返回按键
    );
  }

  static showBulletChat(String avatarUrl, String text, {Duration? duration}) {
    return showToastWidget(
      Container(
        // margin: EdgeInsets.only(left: 20.w),
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(3.0.w),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(40.w),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                avatarUrl,
                width: 45.w,
                height: 45.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: MediaQueryData.fromWindow(window).size.width - 120.w,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(AppUtils.getContext()).dividerColor,
                    fontSize: 16.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      // curve: Curves.elasticOut,
      curve: Curves.easeIn,
      position: StyledToastPosition.left,
      dismissOtherToast: false,
      startOffset: const Offset(0, 4),
      endOffset: const Offset(0, 2),
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      animation: StyledToastAnimation.slideFromBottom,
      animDuration: const Duration(milliseconds: 3000),
      duration: const Duration(milliseconds: 6000),
    );
  }

  static closeLoading() {
    return BotToast.cleanAll();
  }
}
