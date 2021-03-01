import 'package:flutter_music/models/search/hot_music_model.dart';
import 'package:flutter_music/util/keyboard_util.dart';
import 'package:flutter_music/util/tools.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  List searchHistoryList = [];
  List<bool> searchHistoryListBool = [];
  HotMusicModel hmModel;
  TabController tabController;
  ScrollController listController = ScrollController();
  ScrollController listExternalController = ScrollController();
  bool isScroll = true;

  ///初始化ViewModel
  Future<void> initViewModel() async {
    textC?.clear();
    searchHistoryList =
        SpUtil.getStringList(PublicKeys.searchHistoryList) ?? [];
    searchHistoryListBool.clear();
    for (int i = 0; i < searchHistoryList.length; i++) {
      searchHistoryListBool.add(false);
    }
    hmModel = await HotMusicRequest.getHotMusic();

    notifyListeners();
  }

  ///初始化tab控制器
  void initTabController(TickerProvider tickerProvider) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tabController == null) {
        tabController =
            TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
        notifyListeners();
      } else {
        if (tabController.index != 0) tabController.animateTo(0);

      }
    });
  }

  ///清除搜索框
  void clearText() {
    textC?.clear();
    tabController.animateTo(0);
    notifyListeners();
  }

  void onPanDown(int index) {
    searchHistoryListBool[index] = true;
    textC.text = searchHistoryList[index];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabController.animateTo(1);
    });

    notifyListeners();
  }

  void onPanCancel(int index) {
    searchHistoryListBool[index] = false;
    notifyListeners();
  }

  ///存储搜索历史
  void saveHistorySearch(String value) {
    if (value.trim().length > 0) {
      if (!searchHistoryList.contains(value)) {
        if (searchHistoryList.length >= 10) {
          searchHistoryList.removeLast();
          searchHistoryListBool.removeLast();
        }
        searchHistoryList.insert(0, value.trim());
        searchHistoryListBool.add(false);
        SpUtil.setStringList(PublicKeys.searchHistoryList, searchHistoryList);
      }

      ///搜索列表
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tabController.animateTo(1);
      });
    }

    notifyListeners();
  }

  ///点击每条热搜
  void onHotSearchItem(String songName) {
    textC.text = songName;
    KeyboardUtil.closeKeyboardUtil();
    if (!searchHistoryList.contains(songName)) {
      if (searchHistoryList.length >= 10) {
        searchHistoryList.removeLast();
        searchHistoryListBool.removeLast();
      }
      searchHistoryList.insert(0, songName.trim());
      searchHistoryListBool.add(false);
      SpUtil.setStringList(PublicKeys.searchHistoryList, searchHistoryList);
    }

    ///搜索列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabController.animateTo(1);
      notifyListeners();
    });
    notifyListeners();
  }

  ///清除搜索历史
  void clearSearchHistory() {
    searchHistoryList?.clear();
    searchHistoryListBool?.clear();
    SpUtil.setStringList(PublicKeys.searchHistoryList, []);
    notifyListeners();
  }


}
