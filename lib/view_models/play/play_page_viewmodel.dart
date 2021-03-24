import 'dart:async';

import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayPageViewModel extends ChangeNotifier {
  Color negColor = Color(0xffffffff);//取反色
  PaletteGenerator? paletteGenerator;
  TabController? tabC; //tab控制器
  AnimationController? recordC; //唱片控制器
  AnimationController? animationC; //唱片杆控制器
  ScrollController? sc; //歌词滚动控制器
  List<String> lyrics = []; //歌词
  List<int> timeInt = []; //歌词时间seconds秒
  List<String> timeString = []; //歌词时间00:00.00格式
  RegExp reg = RegExp('[0-9]');
  Timer? timer;

  Future<void> updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(AppUtils.getContext().read<PlayBarViewModel>().picUrl),
      maximumColorCount: 20,
    );
    negColor = ColorUtil.negationColor(paletteGenerator!.dominantColor!.color);
    notifyListeners();
  }

  void initViewModel(TickerProvider tickerProvider) {
    if (tabC == null) {
      tabC = TabController(length: 2, vsync: tickerProvider, initialIndex: 0);
    }
    if (sc == null) {
      sc = ScrollController();
    }
  }

  ///初始化动画控制器
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

  void initRecord(BuildContext context) {
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

  ///获取歌词
  Future<void> getLyric() async {
    lyrics.clear();
    timeInt.clear();
    timeString.clear();
    List value = SpUtil.getStringList(PublicKeys.lyrics) ?? [];

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (value.length > 0) {
        for (int i = 0; i < value.length; i++) {
          if (value[i].indexOf("]") == 9) {
            lyrics.add(value[i].substring(10));
            if (value[i].substring(1, value[i].indexOf(']')).startsWith(reg)) {
              timeString.add(value[i].substring(1, value[i].indexOf(']')));
            }
          }
        }
        for (var i = 0; i < timeString.length; i++) {
          timeInt.add((double.parse(timeString[i].split(":")[0]) * 60 +
                  double.parse(timeString[i].split(":")[1] * 1))
              .toInt());
        }
      }
      notifyListeners();
    });
  }

  ///歌词滚动
  void startLyric() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (AppUtils.getContext().read<PlayBarViewModel>().isPlay &&
          sc!.hasClients &&
          lyrics.length > 0) {
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (timeInt.contains(AppUtils.getContext()
              .read<PlayBarViewModel>()
              .position!
              .inSeconds)) {
            if (timeInt.indexOf(AppUtils.getContext()
                    .read<PlayBarViewModel>()
                    .position!
                    .inSeconds) >
                0) {
              if (sc!.hasClients) {
                sc?.animateTo(
                  ((timeInt.indexOf(AppUtils.getContext()
                              .read<PlayBarViewModel>()
                              .position!
                              .inSeconds) +
                          1) *
                      50.0),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              }
            }
          }
          notifyListeners();
        });
      }
    });
  }
}
