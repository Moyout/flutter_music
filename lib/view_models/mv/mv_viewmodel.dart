import 'package:flutter_music/models/mv/mv_detail_model.dart';
import 'package:flutter_music/models/mv/mv_ranklist_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';

class MvViewModel extends ChangeNotifier {
  RefreshController reController = RefreshController();
  MvRankListModel? mvrModel;
  List<bool> isBoolList = [];
  late VideoPlayerController vpController;

  double opacity = 1; //透明度
  int count = 4; //mv数量

  ///初始化viewmodel
  initViewModel() {
    getRankListMv();
  }

  void initBoolList() {
    isBoolList.clear();
    mvrModel!.request!.data!.rankList!.forEach((element) {
      isBoolList.add(false);
    });
  }

  ///获取MV榜
  void getRankListMv() async {
    await MvRankListRequest.getMvRankList().then((value) {
      if (value != null) {
        mvrModel = value;
        initBoolList();
        notifyListeners();
      }
    }).catchError((e) {
      reController.refreshFailed();
    }).whenComplete(() => reController.refreshToIdle());
    count = 4;
    notifyListeners();
  }

  ///加载更多
  void loadMore() {
    if (count != 20) {
      count += 4;
      Future.delayed(Duration(seconds: 1), () {
        reController.loadComplete();
      });
      if (count == 20) Toast.showBottomToast("已加载全部");
      notifyListeners();
    }
  }

  ///播放MV操作
  playMV(int index) async {
    if (!isBoolList[index]) {
      List.generate(isBoolList.length, (index) => isBoolList[index] = false);
      await MvDetailRequest.getMvDetail(mvrModel!.request!.data!.rankList![index].videoInfo!.vid!).then((value) {
        if (value != null) {
          vpController = VideoPlayerController.network(value)
            ..initialize().then((_) {
              vpController.play();
              notifyListeners();
            });
        } else {
          Toast.showBotToast("获取MV失败");
        }
      });
    } else {
      vpController.pause();
    }

    isBoolList[index] = !isBoolList[index];

    notifyListeners();
  }
}
