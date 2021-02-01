import 'package:flutter_music/util/tools.dart';

class PlayBarViewModel extends ChangeNotifier {
  String picUrl =
      "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"; //旋转头像
  bool isPlay = false; //是否播放
  AnimationController controller; //旋转图片控制器
  AudioPlayer audioPlayer; //播放器
  String playUrl = ""; //播放音频地址
  Duration duration;
  Duration position;

  ///初始化ViewModel
  void initViewModel() {
    initRotateImage();
    initAudioPlayer();
  }

  abc(TickerProvider tickerProvider) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller == null) {
        controller = AnimationController(
            duration: Duration(seconds: 10), vsync: tickerProvider);
        initRotateImage();
        notifyListeners();
      }
    });

  }

  ///初始化旋转图片
  void initRotateImage() {
    if (controller != null) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        }
      });
      notifyListeners();
    }
  }

  ///初始化播放器监听
  void initAudioPlayer() {
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    audioPlayer.onDurationChanged.listen((value) {
      duration = value;
    });
    //监听音频位置改变
    audioPlayer.onAudioPositionChanged.listen((p) {
      position = p;
    });
    //完成
    audioPlayer.onPlayerCompletion.listen((event) {
      position = duration;
    });
    //播放错误操作
    audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error :::::::::::::::::::::::: $msg');
      duration = Duration(seconds: 0);
      position = Duration(seconds: 0);
    });
    notifyListeners();
  }

  ///播放操作
  void onPlay() async {
    if (isPlay) {
      isPlay = false;
      controller.stop();
    } else {
      isPlay = true;
      controller.forward();
    }
    notifyListeners();
    // // if (playUrl != "") {
    //   isPlay = !isPlay;
    //   isPlay ? controller.forward() : controller.stop();
    //   // await audioPlayer.play(playUrl);
    //   notifyListeners();
    // // }
  }
}
