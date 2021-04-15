import 'package:flutter_music/models/mv/mv_ranklist_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MvViewModel extends ChangeNotifier {
  RefreshController reController = RefreshController();
  MvRankListModel? mvModel;
  int count = 4; //mv数量

  ///初始化viewmodel
  initViewModel() {
    getRankListMv();
  }

  ///获取MV榜
  void getRankListMv() async {
    await MvRankListRequest.getMvRankList().then((value) {
      if (value != null) {
        mvModel = value;
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
}
