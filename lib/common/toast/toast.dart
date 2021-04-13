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

  static showBottomToast(String text, {Alignment? alignment}) {
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

  static showBulletChat(String text, {Duration? duration}) {
    return showToastWidget(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/login.png",
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Theme.of(AppUtils.getContext()).dividerColor),
          ),
        ],
      ),
      curve: Curves.elasticOut,
      position: StyledToastPosition.center,
      dismissOtherToast: false,
      startOffset: Offset(0, 5),
      endOffset: Offset(0.2, 0),
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      animation: StyledToastAnimation.slideFromBottom,
      animDuration: Duration(milliseconds: 2500),
      duration: Duration(milliseconds: 6000),
    );
  }

  static closeLoading() {
    return BotToast.cleanAll();
  }
}
