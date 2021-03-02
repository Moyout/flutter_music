import 'package:flutter_music/common/toast/toast.dart';
import 'package:flutter_music/models/search/hot_music_model.dart';
import 'package:flutter_music/models/search/music_key_model.dart';
import 'package:flutter_music/models/search/search_list_model.dart';
import 'package:flutter_music/util/keyboard_util.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';

class SearchViewModel extends ChangeNotifier {
  ScrollController listController = ScrollController();
  ScrollController listExternalController = ScrollController();
  TextEditingController textC = TextEditingController();
  List<bool> searchHistoryListBool = [];
  List searchHistoryList = [];
  HotMusicModel hmModel;
  SearchMusicModel smModel;
  MusicKeyModel musicKeyModel;
  TabController tabController;

  bool isLoading = false;
  int page = 1;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listController.addListener(() {
        if (listController.position.maxScrollExtent ==
            listController.position.pixels) {
          page++;
          searchRequest(textC.text, page: page);
          notifyListeners();
          print("page=============================>$page");
        }
      });
      notifyListeners();
    });
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
    page = 1;
    smModel = null;
    tabController.animateTo(0);
    notifyListeners();
  }

  void onPanDown(int index) {
    searchHistoryListBool[index] = true;
    textC.text = searchHistoryList[index];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabController.animateTo(1);
    });
    page = 1;
    smModel = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchRequest(searchHistoryList[index]);
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
      page = 1;
      smModel = null;
      searchRequest(value);

      ///搜索列表
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tabController.animateTo(1);
      });
      notifyListeners();
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
    smModel = null;
    searchRequest(songName);

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

  Future<void> searchRequest(String songName, {int page = 1}) async {
    if (smModel == null) {
      page = 1;
      smModel = await SearchMusicRequest.getSearchMusic(songName);
    } else {
      isLoading = true;
      SearchMusicRequest.getSearchMusic(songName, p: page).then((value) {
        if (value.data.song.list.length > 0) {
          for (var item in value?.data?.song?.list)
            smModel.data.song.list.add(item);
        }
        isLoading = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void getMusicVKey(String songmid, BuildContext context) async {
    musicKeyModel = await MusicKeyRequest.getMusicVKey(songmid);
    if (musicKeyModel.req0.data.midurlinfo[0].purl.length == 0)
      Toast.showBotToast("此歌曲暂不支持播放");
    else
      context.read<PlayBarViewModel>().onPlay();
  }
}
