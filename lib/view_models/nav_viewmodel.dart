import 'package:flutter/rendering.dart';
import 'package:flutter_music/models/login/login_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/login/login_viewmodel.dart';
import 'package:flutter_music/views/navigation_page.dart';

class NavViewModel extends ChangeNotifier {
  List<BottomItem> itemList = [
    BottomItem("音乐馆", Icons.music_note, isActive: true),
    BottomItem("动态", Icons.camera),
    BottomItem("我的", Icons.person),
  ];
  ScrollController? sc; //播放条滚动

  bool isOnTap = false;
  int navIndex = 0;
  PageController pageController = PageController();

  void pageTo(int index) async {
    if (index != navIndex) {
      pageController.jumpToPage(index);
      itemList.forEach((element) {
        element.isActive = false;
      });
      itemList[index].isActive = true;
      navIndex = index;
      notifyListeners();
      if (index == 2) {
        String token = SpUtil.getString(PublicKeys.token) ?? "";
        if (token.length > 0) {
          await LoginRequest.getLogin(headers: {"token": token}).then((value) {
            if (value.message == "Signature has expired") {
              BotToast.showText(text: "登录过期");
              SpUtil.remove(PublicKeys.token);
              AppUtils.getContext().read<LoginViewModel>().isLogin = false;
              notifyListeners();
            } else {
              AppUtils.getContext().read<LoginViewModel>().isLogin = true;
              AppUtils.getContext().read<LoginViewModel>().userName = value.userName.toString();
              notifyListeners();
            }
          });
        }
      }
      notifyListeners();
    }
  }

  void initSC(BuildContext context) {
    if (sc == null) {
      sc = ScrollController();
      sc?.addListener(() {
        if (sc?.position.userScrollDirection == ScrollDirection.forward) {
          sc?.animateTo(
            0,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        } else if (sc?.position.userScrollDirection == ScrollDirection.reverse) {
          sc?.animateTo(
            MediaQuery.of(context).size.width - 110.w,
            duration: Duration(milliseconds: 100),
            curve: Curves.bounceInOut,
          );
        }
      });
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        sc?.animateTo(
          MediaQuery.of(context).size.width - 110.w,
          duration: Duration(milliseconds: 200),
          curve: Curves.bounceOut,
        );
      });
    }
  }
}
