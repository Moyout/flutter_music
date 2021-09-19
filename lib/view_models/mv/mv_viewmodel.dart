import 'package:flutter_music/models/mv/mv_detail_model.dart';
import 'package:flutter_music/models/mv/mv_ranklist_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MvViewModel extends ChangeNotifier {
  RefreshController reController = RefreshController();
  MvRankListModel? mvrModel;
  List<bool> isBoolList = [];
  late VideoPlayerController vpController;
  ChewieController? chewieController;
  double opacity = 1; //透明度
  int count = 4; //mv数量

  ///初始化viewmodel
  initViewModel() {
    getRankListMv();
  }

  void initBoolList() {
    isBoolList.clear();
    for (var _ in mvrModel!.request!.data!.rankList!) {
      isBoolList.add(false);
    }
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
      Future.delayed(const Duration(seconds: 1), () {
        reController.loadComplete();
      });
      if (count == 20) Toast.showBottomToast("已加载全部");
      notifyListeners();
    }
  }

  void initVPController() {
    if (AppUtils.getContext().read<PlayBarViewModel>().isPlay) {
      AppUtils.getContext().read<PlayBarViewModel>().getNowPlayMusic();
    }
  }

  ///播放MV操作
  playMV(int index) async {
    initVPController();
    if (!isBoolList[index]) {
      List.generate(isBoolList.length, (index) => isBoolList[index] = false);
      await MvDetailRequest.getMvDetail(mvrModel!.request!.data!.rankList![index].videoInfo!.vid!).then((value) async {
        if (value != null) {
          vpController = VideoPlayerController.network(value);
          await vpController.initialize();
          chewieController = ChewieController(
            videoPlayerController: vpController,
            autoPlay: true,
            looping: true,
            playbackSpeeds: [0.5, 1, 1.5, 2],
          );
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
