import 'dart:convert';

import 'package:flutter_music/models/play/lyric_model.dart';
import 'package:flutter_music/models/search/hot_music_model.dart';
import 'package:flutter_music/models/search/music_key_model.dart';
import 'package:flutter_music/models/search/search_list_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchViewModel extends ChangeNotifier {

  RefreshController rC = RefreshController();
  TextEditingController textC = TextEditingController();
  List<bool> searchHistoryListBool = [];
  List<String> searchHistoryList = [];
  HotMusicModel? hmModel;
  SearchMusicModel? smModel;
  MusicKeyModel? musicKeyModel;
  bool isSearchList = false;
  int page = 1;

  ///初始化ViewModel
  Future<void> initViewModel() async {
    isSearchList = false;
    textC.clear();
    searchHistoryList = SpUtil.getStringList(PublicKeys.searchHistoryList) ?? [];
    searchHistoryListBool.clear();
    for (int i = 0; i < searchHistoryList.length; i++) {
      searchHistoryListBool.add(false);
    }
    hmModel = await HotMusicRequest.getHotMusic();
    notifyListeners();
  }

  ///初始化tab控制器
  void initTabController() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  ///下拉刷新
  Future<void> onRefresh() async {
    if (!isSearchList) {
      hmModel = await HotMusicRequest.getHotMusic().whenComplete(() => rC.refreshToIdle());
    } else {
      smModel = null;
      await searchRequest(textC.text, page: 1).whenComplete(() => rC.refreshToIdle());
      notifyListeners();
    }

    notifyListeners();
  }

  ///上拉加载
 void onLoading() async {
    page++;
    debugPrint("onLoading------------>$page");
    await searchRequest(textC.text, page: page).whenComplete(() => rC.loadComplete());
    notifyListeners();
  }

  ///清除搜索框
  void clearText() {
    textC.clear();
    page = 1;
    smModel = null;
    isSearchList = false;
    notifyListeners();
  }

  void onPanDown(int index) {
    KeyboardUtil.closeKeyboardUtil();
    searchHistoryListBool[index] = true;
    textC.text = searchHistoryList[index];
    page = 1;
    smModel = null;

    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   tabController?.animateTo(1);
    // });
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   searchRequest(searchHistoryList[index]);
    // });
    notifyListeners();
  }

  Future<void> onTapUp(int index) async {
    smModel = null;
    await searchRequest(searchHistoryList[index], page: 1);
    isSearchList = true;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
    // searchRequest(searchHistoryList[index]);
    notifyListeners();
    });
  }

  void onPanCancel(int index) {
    searchHistoryListBool[index] = false;
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    notifyListeners();
    // });
  }

  ///存储搜索历史
  void saveHistorySearch(String value) {

    if (value.trim().isNotEmpty) {
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
      isSearchList = true;
      notifyListeners();
    }

    notifyListeners();
  }

  ///点击每条热搜
  void onHotSearchItem(String songName) {
    isSearchList = true;
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
    searchRequest(songName, page: 1);

    notifyListeners();
  }

  ///清除搜索历史
  void clearSearchHistory() {
    isSearchList = false;
    searchHistoryList.clear();
    searchHistoryListBool.clear();
    SpUtil.setStringList(PublicKeys.searchHistoryList, []);
    notifyListeners();
  }

  ///加载更多
  Future<void> searchRequest(String songName, {int page = 1}) async {
    if (smModel == null) {
      this.page = 1;
      smModel = await SearchMusicRequest.getSearchMusic(songName);
    } else {
      await SearchMusicRequest.getSearchMusic(songName, p: page).then((value) {
        if (value!.data!.song!.list!.isNotEmpty) {
          for (var item in value.data!.song!.list!) {
            smModel!.data!.song!.list!.add(item);
          }
        } else {
          Toast.showBottomToast("已加载更多");
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }

  ///获取VKey并播放
  Future<bool> getMusicVKey(
    BuildContext context,
    String albumMid,
    String songMid,
    String songName,
    String singer,
    String topid,
  ) async {
    // print("index________________________________________________>$index");
    // String _albumMid = smModel!.data!.song!.list![index].albummid!.trim();
    // String _songMid = smModel!.data!.song!.list![index].songmid!;
    // String _songName = smModel!.data!.song!.list![index].songname!;
    // String _singer =
    //     "${smModel!.data!.song!.list![index].singer![0]!.name} ${smModel!.data!.song!.list![index].singer!.length > 1 ? "/${smModel!.data!.song!.list![index].singer![1]!.name}" : ""}";

    musicKeyModel = await MusicKeyRequest.getMusicVKey(songMid);

    if (musicKeyModel!.req0!.data!.midurlinfo![0].purl!.isEmpty) {
      Toast.showBotToast("此歌曲暂不支持播放");
    } else {
      ///***************************存储播放历史**********************************

      List<String> list = [];
      list = SpUtil.getStringList(PublicKeys.playHistory) ?? [];
      Map musicMap = {
        PublicKeys.songmid: songMid,
        PublicKeys.albumMid: albumMid.isNotEmpty ? albumMid : "",
        PublicKeys.songName: songName,
        PublicKeys.singer: singer,
        PublicKeys.topid: topid,
      };
      if (!list.contains(jsonEncode(musicMap))) list.insert(0, jsonEncode(musicMap));
      await SpUtil.setStringList(PublicKeys.playHistory, list);
      debugPrint("------------------------------------------->${SpUtil.getStringList(PublicKeys.playHistory)}");

      ///********************************end************************************

      String _playUrl = "http://ws.stream.qqmusic.qq.com/" + musicKeyModel!.req0!.data!.midurlinfo![0].purl!;

      // await SpUtil.setString(PublicKeys.nowPlayURL, _playUrl);
      await SpUtil.setStringList(PublicKeys.nowPlaySongDetails, [
        songMid, //songmid
        albumMid.isNotEmpty ? albumMid : "", //播放图片
        songName, //歌名
        singer, //歌手
        topid, //歌曲评论id
      ]);

      if (context.read<PlayBarViewModel>().isPlay) {
        context.read<PlayBarViewModel>().isPlay = false;
        context.read<PlayBarViewModel>().audioPlayer?.pause();
      }
      context.read<PlayBarViewModel>().onPlay(_playUrl);

      if (albumMid.isNotEmpty) {
        context.read<PlayBarViewModel>().picUrl = "https://y.gtimg.cn/music/photo_new/T002R300x300M000$albumMid.jpg";
      } else {
        context.read<PlayBarViewModel>().picUrl =
            'http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg';
      }
      await LyricRequest.getLyric(songMid);
      AppUtils.getContext().read<PlayBarViewModel>().updatePlayDetails();

      notifyListeners();
    }
    notifyListeners();

    return AppUtils.getContext().read<PlayBarViewModel>().isPlay;
  }

  ///播放当前
  Future<String?> onPlay(String songMid) async {
    musicKeyModel = await MusicKeyRequest.getMusicVKey(songMid);
    notifyListeners();
    if (musicKeyModel!.req0!.data!.midurlinfo![0].purl!.isEmpty) {
      Toast.showBotToast("此歌曲暂不支持播放");
      return null;
    } else {
      String _playUrl = "http://ws.stream.qqmusic.qq.com/" + musicKeyModel!.req0!.data!.midurlinfo![0].purl!;
      return _playUrl;
    }
  }

  ///监听返回
  bool onWillPopScope() {
    if (isSearchList) {
      isSearchList = false;
      notifyListeners();
      return false;
    }
    return true;
    // if (!isSearchList) {
    //   return true;
    // } else {
    //   isSearchList = false;
    //   notifyListeners();
    //   return false;
    // }
  }
}
