import 'package:bot_toast/bot_toast.dart';

class Toast {
  //toast提示
  static showBotToast(String text, {int seconds = 3}) {
    return BotToast.showSimpleNotification(
      title: text,
      hideCloseButton: true,
      duration: Duration(seconds: seconds),
    );
  }

  static showBottomToast(String text) {
    return BotToast.showText(
      text: text,
//      contentColor: Colors.white,
//      backgroundColor: Colors.grey
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

  static closeLoading() {
    return BotToast.cleanAll();
  }
}
