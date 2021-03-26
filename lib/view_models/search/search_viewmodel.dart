import 'dart:convert';

import 'package:flutter_music/models/play/lyric_model.dart';
import 'package:flutter_music/models/search/hot_music_model.dart';
import 'package:flutter_music/models/search/music_key_model.dart';
import 'package:flutter_music/models/search/search_list_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';

class SearchViewModel extends ChangeNotifier {
  ScrollController listController = ScrollController();
  ScrollController listExternalController = ScrollController();
  TextEditingController textC = TextEditingController();
  List<bool> searchHistoryListBool = [];
  List<String> searchHistoryList = [];
  HotMusicModel? hmModel;
  SearchMusicModel? smModel;
  MusicKeyModel? musicKeyModel;
  TabController? tabController;
  bool isLoading = false;
  int page = 1;

  ///初始化ViewModel
  Future<void> initViewModel() async {
    textC.clear();
    searchHistoryList =
        SpUtil.getStringList(PublicKeys.searchHistoryList) ?? [];
    searchHistoryListBool.clear();
    for (int i = 0; i < searchHistoryList.length; i++) {
      searchHistoryListBool.add(false);
    }
    hmModel = await HotMusicRequest.getHotMusic();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (tabController == null) {
        tabController =
            TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
        notifyListeners();
      } else {
        if (tabController?.index != 0) tabController?.animateTo(0);
      }
    });
  }

  ///清除搜索框
  void clearText() {
    textC.clear();
    page = 1;
    smModel = null;
    tabController?.animateTo(0);
    notifyListeners();
  }

  void onPanDown(int index) {
    searchHistoryListBool[index] = true;
    textC.text = searchHistoryList[index];
    page = 1;
    smModel = null;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      tabController?.animateTo(1);
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      searchRequest(searchHistoryList[index]);
    });
    notifyListeners();
  }

  void onPanCancel(int index) {
    searchHistoryListBool[index] = false;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
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
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        tabController?.animateTo(1);
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      tabController?.animateTo(1);
      notifyListeners();
    });
    notifyListeners();
  }

  ///清除搜索历史
  void clearSearchHistory() {
    searchHistoryList.clear();
    searchHistoryListBool.clear();
    SpUtil.setStringList(PublicKeys.searchHistoryList, []);
    notifyListeners();
  }

  ///加载更多
  Future<void> searchRequest(String songName, {int page = 1}) async {
    if (smModel == null) {
      page = 1;
      smModel = await SearchMusicRequest.getSearchMusic(songName);
    } else {
      isLoading = true;
      SearchMusicRequest.getSearchMusic(songName, p: page).then((value) {
        if (value!.data!.song!.list!.length > 0) {
          for (var item in value.data!.song!.list!)
            smModel!.data!.song!.list!.add(item);
        } else
          Toast.showBottomToast("已加载全部");
        isLoading = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  ///获取VKey并播放
  void getMusicVKey(
    BuildContext context,
    String albumMid,
    String songMid,
    String songName,
    String singer,
  ) async {
    // print("index________________________________________________>$index");
    // String _albumMid = smModel!.data!.song!.list![index].albummid!.trim();
    // String _songMid = smModel!.data!.song!.list![index].songmid!;
    // String _songName = smModel!.data!.song!.list![index].songname!;
    // String _singer =
    //     "${smModel!.data!.song!.list![index].singer![0]!.name} ${smModel!.data!.song!.list![index].singer!.length > 1 ? "/${smModel!.data!.song!.list![index].singer![1]!.name}" : ""}";

    musicKeyModel = await MusicKeyRequest.getMusicVKey(songMid);

    if (musicKeyModel!.req0!.data!.midurlinfo![0].purl!.length == 0)
      Toast.showBotToast("此歌曲暂不支持播放");
    else {
      ///***************************存储播放历史**********************************

      List<String> list = [];
      list = SpUtil.getStringList(PublicKeys.playHistory) ?? [];
      Map musicMap = {
        PublicKeys.songmid: "$songMid",
        PublicKeys.albumMid: albumMid.length > 0 ? albumMid : "",
        PublicKeys.songName: "$songName",
        PublicKeys.singer: "$singer",
      };
      if (!list.contains(jsonEncode(musicMap)))
        list.insert(0, jsonEncode(musicMap));
      await SpUtil.setStringList(PublicKeys.playHistory, list);
      print(SpUtil.getStringList(PublicKeys.playHistory));

      ///********************************end************************************

      String _playUrl = "http://ws.stream.qqmusic.qq.com/" +
          musicKeyModel!.req0!.data!.midurlinfo![0].purl!;

      // await SpUtil.setString(PublicKeys.nowPlayURL, _playUrl);
      await SpUtil.setStringList(PublicKeys.nowPlaySongDetails, [
        songMid, //songmid
        albumMid.length > 0 ? albumMid : "", //播放图片
        songName, //歌名
        singer, //歌手
      ]);

      if (context.read<PlayBarViewModel>().isPlay) {
        context.read<PlayBarViewModel>().isPlay = false;
        context.read<PlayBarViewModel>().audioPlayer?.pause();
      }
      context.read<PlayBarViewModel>().onPlay(_playUrl);
      if (albumMid.length > 0)
        context.read<PlayBarViewModel>().picUrl =
            "https://y.gtimg.cn/music/photo_new/T002R300x300M000$albumMid.jpg";
      else
        context.read<PlayBarViewModel>().picUrl =
            'http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg';
      await LyricRequest.getLyric(songMid);
      AppUtils.getContext().read<PlayBarViewModel>().updatePlayDetails();

      notifyListeners();
    }
    notifyListeners();
  }

  ///播放当前
  Future<String?> onPlay(String songMid) async {
    musicKeyModel = await MusicKeyRequest.getMusicVKey(songMid);
    notifyListeners();
    if (musicKeyModel!.req0!.data!.midurlinfo?[0].purl!.length == 0) {
      Toast.showBotToast("此歌曲暂不支持播放");
      return null;
    } else {
      String _playUrl = "http://ws.stream.qqmusic.qq.com/" +
          musicKeyModel!.req0!.data!.midurlinfo![0].purl!;
      return _playUrl;
    }
  }

  ///监听返回
  bool onWillPopScope() {
    if (tabController?.index == 0) {
      return true;
    } else {
      tabController?.animateTo(0);
      notifyListeners();
      return false;
    }
  }
}
