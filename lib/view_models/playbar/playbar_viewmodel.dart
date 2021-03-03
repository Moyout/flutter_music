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
    // initRotateImage();
    initAudioPlayer();
  }

  init(TickerProvider tickerProvider) {
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
    if (audioPlayer == null) {
      audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
      audioPlayer.onDurationChanged.listen((value) {
        duration = value;
        notifyListeners();
      });
      //监听音频位置改变
      audioPlayer.onAudioPositionChanged.listen((p) {
        position = p;
        notifyListeners();
      });
      //完成
      audioPlayer.onPlayerCompletion.listen((event) {
        position = duration;
        notifyListeners();
      });
      //播放错误操作
      audioPlayer.onPlayerError.listen((msg) {
        print('audioPlayer error :::::::::::::::::::::::: $msg');
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
        notifyListeners();
      });
    }
  }

  void getNowPlayMusic() {
    // print(audioPlayer.state);

    // List<String> details = SpUtil.getStringList(PublicKeys.nowPlaySongDetails);
    // if (details.length > 0) {
    //   onPlay(details[0]);
    // }
    // print(details);
    print("来了老弟");
    String playUrl = SpUtil.getString(PublicKeys.nowPlayURL);
    if (playUrl.length > 0) onPlay(playUrl);
    print(playUrl);
  }

  ///播放操作
  void onPlay(String playUrl) async {
    // audioPlayer.stop();
    if (isPlay) {
      isPlay = false;
      controller?.stop();
      audioPlayer.pause();
    } else {
      // if (audioPlayer.state == AudioPlayerState.PAUSED) {
      //   audioPlayer.resume();
      // } else
      await audioPlayer.play("$playUrl", isLocal: false);
      isPlay = true;
      controller?.forward();
    }
    print(audioPlayer.state);
    notifyListeners();
    // // if (playUrl != "") {
    //   isPlay = !isPlay;
    //   isPlay ? controller.forward() : controller.stop();
    //   // await audioPlayer.play(playUrl);
    //   notifyListeners();
    // // }
  }
}
