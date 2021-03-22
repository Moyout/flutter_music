import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';

class PlayPageViewModel extends ChangeNotifier {
  TabController? tabC;
  AnimationController? recordC; //唱片控制器
  AnimationController? animationC; //唱片杆控制器

  void initViewModel(TickerProvider tickerProvider) {
    if (tabC == null) {
      tabC = TabController(length: 2, vsync: tickerProvider, initialIndex: 0);
    }
  }

  void initAnimationController(TickerProvider tickerProvider) {
    if (recordC == null) {
      recordC = AnimationController(
          duration: Duration(seconds: 10), vsync: tickerProvider);
    }
    if (animationC == null) {
      animationC = AnimationController(
          duration: Duration(seconds: 1), vsync: tickerProvider);
    }
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (recordC != null) {
        recordC!.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            recordC?.reset();
            recordC?.forward();
          }
        });
        notifyListeners();
      }
    });
  }

  initRecord(BuildContext context) {
    if (context.read<PlayBarViewModel>().isPlay) {
      animationC?.forward();
      recordC?.forward();
    } else {
      animationC?.reverse();
    }
  }

  void controllerAnimation() {
    if (animationC?.status == AnimationStatus.dismissed) {
      animationC?.forward();
    } else if (animationC?.status == AnimationStatus.completed) {
      animationC?.reverse();
    }
    // recordC?.forward();
  }
}
