import 'dart:async';

import 'package:flutter_music/models/login/login_model.dart';
import 'package:flutter_music/models/login/send_code_model.dart';
import 'package:flutter_music/models/login/sign_model.dart';
import 'package:flutter_music/util/tools.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController(); //用户名
  TextEditingController textPswC = TextEditingController(); //密码
  TextEditingController textEmailC = TextEditingController(); //邮箱
  TextEditingController textCodeC = TextEditingController(); //验证码
  LoginModel lModel = LoginModel();
  bool isHide = true; //是否显示输入文字
  String teddyStatus = "idle"; //flare动画
  TabController? tabController;
  bool isLogin = false; //是否登录
  String userName = ""; //用户名

  ///初始化
  void initViewModel(TickerProvider tickerProvider) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      textC.clear();
      textPswC.clear();
      textEmailC.clear();
      textCodeC.clear();
      isHide = true;
      teddyStatus = "idle";
      // tabController?.animateTo(0);
      textC.addListener(() {
        notifyListeners();
      });
      textPswC.addListener(() {
        notifyListeners();
      });
      textEmailC.addListener(() {
        notifyListeners();
      });
      textCodeC.addListener(() {
        notifyListeners();
      });
    });

    if (tabController == null) {
      tabController = TabController(length: 2, vsync: tickerProvider);
      tabController!.addListener(() {
        notifyListeners();
      });
    }
  }

  ///输入框文字设置是否显示
  void setHideText() {
    isHide = !isHide;
    notifyListeners();
  }

  ///点击空白区
  void onBlank(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      KeyboardUtil.closeKeyboardUtil();
      setTeddyStatus();
      notifyListeners();
    });
  }

  ///输入值改变时
  void onChanged() {
    if (teddyStatus != "hands_up") {
      teddyStatus = "hands_up";
    }
  }

  void onTap() => setTeddyTest();

  Future<void> setTeddyFail() async {
    if (teddyStatus != "hands_up") {
      teddyStatus = "fail";
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1500), () {
        teddyStatus = "idle";
      });
    }
    notifyListeners();
  }

  Future<void> setTeddyTest() async {
    if (teddyStatus == "hands_up") {
      teddyStatus = "hands_down";
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1500), () {
        teddyStatus = "test";
      });
    } else {
      teddyStatus = "test";
    }
    notifyListeners();
  }

  ///设置动画状态
  Future<void> setTeddyStatus() async {
    if (teddyStatus == "hands_up") {
      teddyStatus = "hands_down";
      await Future.delayed(const Duration(milliseconds: 1500), () {
        teddyStatus = "idle";
      });
      notifyListeners();
    } else {
      teddyStatus = "idle";
      notifyListeners();
    }
    notifyListeners();
  }

  ///发送验证码
  void sendCode() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      KeyboardUtil.closeKeyboardUtil();
      if (isEmail(textEmailC.text) && textC.text.length >= 6 && textPswC.text.length >= 6) {
        await SendCodeRequest.sendCode(textEmailC.text).then((value) {
          BotToast.showText(text: value.message.toString());
        });
      } else {
        BotToast.showText(text: "请输入完整信息");
      }
    });
  }

  ///登录/注册
  void onSubmitted() async {
    if (tabController?.index == 0) {
      if (textC.text.length >= 6 &&
          textPswC.text.length >= 6 &&
          isEmail(textEmailC.text) &&
          textCodeC.text.length == 6) {
        await SignRequest.getSign(
          textC.text,
          textPswC.text,
          textEmailC.text,
          textCodeC.text,
        ).then((value) {
          BotToast.showText(text: value.message.toString());
          if (value.message == "注册成功") tabController?.animateTo(1);
        });
      } else {
        BotToast.showText(text: "请输入完整信息");
      }
    } else {
      if (textC.text.isNotEmpty && textPswC.text.length >= 6) {
        lModel = await LoginRequest.getLogin(userName: textC.text, passWord: textPswC.text);
        BotToast.showText(text: lModel.message.toString());
        if(lModel.message=="登录成功!"){
          teddyStatus = "success";
          notifyListeners();
          isLogin = true;
          userName = lModel.userName ?? "";
          await SpUtil.setString(PublicKeys.token, lModel.token ?? "");
          debugPrint("------------>token${SpUtil.getString(PublicKeys.token)}");
              await Future.delayed(const Duration(milliseconds: 1500), () {
                RouteUtil.pop(AppUtils.getContext());
              });
        }else{
          setTeddyFail();
        }
        //     .then((value) async {
        //   BotToast.showText(text: value.message.toString());
        //   if (value.message == "登录成功!") {
        //     teddyStatus = "success";
        //     notifyListeners();
        //
        //     isLogin = true;
        //     userName = value.userName ?? "";
        //     await SpUtil.setString(PublicKeys.token, value.token ?? "");
        //     BotToast.showText(text: "token::::::${value.token}");
        //     debugPrint("------------>token${SpUtil.getString(PublicKeys.token)}");
        //     await Future.delayed(const Duration(milliseconds: 1500), () {
        //       RouteUtil.pop(AppUtils.getContext());
        //     });
        //     notifyListeners();
        //   } else {
        //     setTeddyFail();
        //   }
        // })

      } else {
        BotToast.showText(text: "请输入完整信息");
      }
    }
  }
}
