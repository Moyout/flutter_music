import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';
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
  List<String> playDetails = [];

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
        AppUtils.getContext().read<PlayPageViewModel>().recordC?.stop();
        AppUtils.getContext().read<PlayPageViewModel>().controllerAnimation();
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
    playDetails = SpUtil.getStringList(PublicKeys.nowPlaySongDetails)!;
    if (playDetails.length > 0) {
      // picUrl = playDetails[1];
      if (playDetails[1].length > 0)
        picUrl =
            "https://y.gtimg.cn/music/photo_new/T002R300x300M000${playDetails[1]}.jpg";
      // notifyListeners();
    }
  }

  void updatePlayDetails() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      playDetails = SpUtil.getStringList(PublicKeys.nowPlaySongDetails)!;
      notifyListeners();
    });
  }

  ///播放按钮
  void getNowPlayMusic() {
    playDetails = SpUtil.getStringList(PublicKeys.nowPlaySongDetails)!;
    notifyListeners();
    if (audioPlayer?.state == null) {
      if (playDetails.length > 0) {
        AppUtils.getContext()
            .read<SearchViewModel>()
            .onPlay(playDetails[0])
            .then((value) {
          if (value != null) {
            onPlay(value);
            AppUtils.getContext().read<PlayPageViewModel>().recordC?.forward();
            AppUtils.getContext()
                .read<PlayPageViewModel>()
                .animationC
                ?.forward();
          }
        });
      }
    } else if (audioPlayer?.state == AudioPlayerState.PAUSED) {
      audioPlayer?.resume();
      isPlay = true;
      controller?.forward();
      AppUtils.getContext().read<PlayPageViewModel>().recordC?.forward();
      AppUtils.getContext().read<PlayPageViewModel>().animationC?.forward();
    } else if (audioPlayer?.state == AudioPlayerState.PLAYING) {
      isPlay = false;
      audioPlayer?.pause();
      controller?.stop();
      AppUtils.getContext().read<PlayPageViewModel>().recordC?.stop();
      AppUtils.getContext().read<PlayPageViewModel>().animationC?.reverse();
      // AppUtils.getContext().read<PlayPageViewModel>().timer?.cancel();

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

  ///拉动进度条
  void setPlayProgress(v) {
    if (position != null) {
      try {
        final position = v * duration?.inMilliseconds;
        audioPlayer?.seek(Duration(milliseconds: position.round()));
        notifyListeners();
      } catch (e) {
        print("-------------------拉动进度条错误------------------------>$e");
      }
    }
  }
}
