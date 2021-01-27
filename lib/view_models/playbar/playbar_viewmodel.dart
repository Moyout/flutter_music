import 'package:flutter_music/util/tools.dart';

class PlayBarViewModel extends ChangeNotifier {
  bool isPlay = false; //是否播放
  AnimationController controller; //旋转图片控制器
  AudioPlayer audioPlayer; //播放器
  Duration duration;
  Duration position;

  ///初始化ViewModel
  void initViewModel() {
    initRotateImage();
    initAudioPlayer();
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
  onPlay() {
    isPlay = !isPlay;
    isPlay ?controller.forward():controller.stop();
    notifyListeners();
  }
}
