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

  static showLoadingToast({int seconds = 1}) {
    return BotToast.showLoading(
      duration: Duration(seconds: seconds),
      clickClose: true,
    );
  }
}
