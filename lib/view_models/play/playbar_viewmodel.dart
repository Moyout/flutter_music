import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class PlayBarViewModel extends ChangeNotifier {
  String picUrl =
      "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"; //旋转头像
  bool isPlay = false; //是否播放
  AnimationController? controller; //旋转图片控制器
  AudioPlayer? audioPlayer; //播放器
  // String playUrl = ""; //播放音频地址
  Duration? duration;
  Duration? position;
  List<String>? playDetails;

  ///初始化ViewModel
  void initViewModel() {
    // initRotateImage();
    initAudioPlayer();
  }

  void init(TickerProvider tickerProvider) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (controller == null) {
        controller = AnimationController(
            duration: Duration(seconds: 10), vsync: tickerProvider);
        initRotateImage();
        notifyListeners();
      }

      if (AppUtils.getContext().read<PlayBarViewModel>().isPlay) {
        controller?.forward();
        notifyListeners();
      }
    });
  }

  ///初始化旋转图片
  void initRotateImage() {
    if (controller != null) {
      controller!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller?.reset();
          controller?.forward();
        }
      });
      notifyListeners();
    }
  }

  ///初始化播放器监听
  void initAudioPlayer() {
    if (audioPlayer == null) {
      audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
      audioPlayer?.onDurationChanged.listen((value) {
        duration = value;
        notifyListeners();
      });
      //监听音频位置改变
      audioPlayer?.onAudioPositionChanged.listen((p) {
        position = p;
        notifyListeners();
      });
      //完成
      audioPlayer?.onPlayerCompletion.listen((event) {
        position = duration;
        print("播放结束");
        isPlay = false;
        controller?.stop();
        audioPlayer?.pause();
        notifyListeners();
      });
      //播放错误操作
      audioPlayer?.onPlayerError.listen((msg) {
        print('audioPlayer error :::::::::::::::::::::::: $msg');
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
        notifyListeners();
      });
    }
    playDetails = SpUtil.getStringList(PublicKeys.nowPlaySongDetails);
    if (playDetails!.length > 0) {
      picUrl = playDetails![1];
      // notifyListeners();
    }
  }

  void getNowPlayMusic(BuildContext context) {
    print("来了老弟");
    if (audioPlayer?.state == null) {
      if (playDetails!.length > 0) {
        context.read<SearchViewModel>().onPlay(playDetails![0]).then((value) {
          if (value != null) onPlay(value);
          print(value);
        });
      }
    } else if (audioPlayer?.state == AudioPlayerState.PAUSED) {
      audioPlayer?.resume();
      isPlay = true;
      controller?.forward();
    } else if (audioPlayer?.state == AudioPlayerState.PLAYING) {
      isPlay = false;
      audioPlayer?.pause();
      controller?.stop();
    }
    notifyListeners();
  }

  ///播放操作
  void onPlay(String playUrl) async {
    // audioPlayer.stop();
    if (isPlay) {
      isPlay = false;
      controller?.stop();
      audioPlayer?.pause();
    } else {
      await audioPlayer?.play("$playUrl", isLocal: false);
      isPlay = true;
      controller?.forward();
    }
    notifyListeners();
  }
}
