import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/navigation_page.dart';

class NavViewModel extends ChangeNotifier {
  List<BottomItem> itemList = [
    BottomItem("音乐馆", Icons.music_note, isActive: true),
    BottomItem("动态", Icons.camera),
    BottomItem("我的", Icons.person),
  ];

  bool isOnTap = false;
  int navIndex = 0;
  PageController pageController = PageController();

  void pageTo(int index) {
    pageController.jumpToPage(index);
    itemList.forEach((element) {
      element.isActive = false;
    });
    itemList[index].isActive = true;
    navIndex = index;
    notifyListeners();
  }


}
