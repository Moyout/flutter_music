import 'package:flutter_music/models/search/hot_music_model.dart';
import 'package:flutter_music/util/tools.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  List searchHistoryList = [];
  List<bool> searchHistoryListBool = [];
  HotMusicModel hmModel;
  TabController tabController;
  ScrollController listController = ScrollController();
  bool isScroll = true;

  ///初始化ViewModel
  Future<void> initViewModel() async {
    searchHistoryList =
        SpUtil.getStringList(PublicKeys.searchHistoryList) ?? [];
    searchHistoryListBool.clear();
    for (int i = 0; i < searchHistoryList.length; i++) {
      searchHistoryListBool.add(false);
    }
    hmModel = await HotMusicRequest.getHotMusic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listController.addListener(() {
        if (listController.hasClients) {
          if (listController.offset ==
              listController.position.maxScrollExtent) {
            // isScroll = false;
          }
        }
        print(listController.offset.px);
        print(listController.position);
        print(listController.position.physics.minFlingVelocity);
        notifyListeners();
      });
    });

    notifyListeners();
  }

  ///初始化tab控制器
  void initTabController(TickerProvider tickerProvider) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tabController == null) {
        tabController = TabController(length: 2, vsync: tickerProvider);
        notifyListeners();
      }
    });
  }

  ///清除搜索框
  void clearText() {
    textC.clear();
    notifyListeners();
  }

  void onPanDown(int index) {
    searchHistoryListBool[index] = true;
    notifyListeners();
  }

  void onPanCancel(int index) {
    searchHistoryListBool[index] = false;
    notifyListeners();
  }

  ///存储搜索历史
  void saveHistorySearch(String value) {
    if (!searchHistoryList.contains(value) && textC.text.length > 0) {
      if (searchHistoryList.length >= 10) {
        searchHistoryList.removeLast();
        searchHistoryListBool.removeLast();
      }
      searchHistoryList.insert(0, value);
      searchHistoryListBool.add(false);
      SpUtil.setStringList(PublicKeys.searchHistoryList, searchHistoryList);
    }
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
