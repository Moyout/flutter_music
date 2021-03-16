import 'dart:async';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter_music/util/tools.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  TextEditingController textPswC = TextEditingController();
  TextEditingController textEmailC = TextEditingController();
  TextEditingController textCodeC = TextEditingController();
  bool isHide = true; //是否显示输入文字
  String teddyStatus = "idle"; //flare动画
  TabController? tabController;

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

  void onTap() => setTeddyStatus();

  Future<void> setTeddyFail() async {
    if (teddyStatus != "hands_up") {
      teddyStatus = "fail";
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 1500), () {
        teddyStatus = "idle";
      });
    }
    notifyListeners();
  }

  ///设置动画状态
  Future<void> setTeddyStatus() async {
    if (teddyStatus == "hands_up") {
      teddyStatus = "hands_down";
      await Future.delayed(Duration(milliseconds: 1500), () {
        teddyStatus = "idle";
      });
      notifyListeners();
    } else {
      teddyStatus = "idle";
      notifyListeners();
    }
    notifyListeners();
  }

  void onSubmitted() {}
}
