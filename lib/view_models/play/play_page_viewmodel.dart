import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_music/models/play/commentlist_model.dart';
import 'package:flutter_music/models/play/download_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:path_provider/path_provider.dart';

class PlayPageViewModel extends ChangeNotifier {
  Color negColor = const Color(0xffffffff); //取反色
  PaletteGenerator? paletteGenerator;
  TabController? tabC; //tab控制器
  AnimationController? recordC; //唱片控制器
  AnimationController? animationC; //唱片杆控制器
  ScrollController? sc; //歌词滚动控制器
  List<String> lyrics = []; //歌词
  List<int> timeInt = []; //歌词时间seconds秒
  List<String> timeString = []; //歌词时间00:00.00格式
  bool isLike = false; //是否收藏
  bool isDownload = false; //是否下载
  RegExp reg = RegExp('[0-9]');
  int downloadProgress = 0; //下载进度
  bool isBulletChat = false;
  CommentListModel? clModel;
  Timer? timer; //歌词滚动
  Timer? timer2; //弹幕
  int index = 0; //歌曲评论列表index
  int page = 0; //歌曲评论列表页

  Future<void> updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(AppUtils.getContext().read<PlayBarViewModel>().picUrl),
      maximumColorCount: 20,
    );
    negColor = ColorUtil.negationColor(paletteGenerator!.dominantColor!.color);
    notifyListeners();
  }

  void initViewModel(TickerProvider tickerProvider) {
    tabC ??= TabController(length: 2, vsync: tickerProvider, initialIndex: 0);
    sc ??= ScrollController();
  }

  ///初始化动画控制器
  void initAnimationController(TickerProvider tickerProvider) {
    recordC ??= AnimationController(duration: const Duration(seconds: 10), vsync: tickerProvider);
    animationC ??= AnimationController(duration: const Duration(seconds: 1), vsync: tickerProvider);
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

  void initRecord() {
    if (AppUtils.getContext().read<PlayBarViewModel>().isPlay) {
      animationC?.forward();
      recordC?.forward();
    } else {
      animationC?.reverse();
    }
  }

  ///唱片杆
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
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          if (value[i].indexOf("]") == 9) {
            lyrics.add(value[i].substring(10));
            if (value[i].substring(1, value[i].indexOf(']')).startsWith(reg)) {
              timeString.add(value[i].substring(1, value[i].indexOf(']')));
            }
          }
        }
        for (var i = 0; i < timeString.length; i++) {
          timeInt.add(
              (double.parse(timeString[i].split(":")[0]) * 60 + double.parse(timeString[i].split(":")[1] * 1)).toInt());
        }
      }
      notifyListeners();
    });
  }

  ///歌词滚动
  void startLyric() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (AppUtils.getContext().read<PlayBarViewModel>().isPlay && sc!.hasClients && lyrics.isNotEmpty) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (timeInt.contains(AppUtils.getContext().read<PlayBarViewModel>().position!.inSeconds)) {
            if (timeInt.indexOf(AppUtils.getContext().read<PlayBarViewModel>().position!.inSeconds) > 0) {
              if (sc!.hasClients) {
                sc?.animateTo(
                  ((timeInt.indexOf(AppUtils.getContext().read<PlayBarViewModel>().position!.inSeconds) + 1) * 50.0),
                  duration: const Duration(milliseconds: 500),
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

  ///设置收藏
  Future<void> setCollect(List songDetails) async {
    if (songDetails.isNotEmpty) {
      ///***************************存储收藏**********************************
      List<String> list = SpUtil.getStringList(PublicKeys.collectMusic) ?? [];
      Map musicMap = {
        PublicKeys.songmid: songDetails[0],
        PublicKeys.albumMid: songDetails[1].length > 0 ? songDetails[1] : "",
        PublicKeys.songName: songDetails[2],
        PublicKeys.singer: songDetails[3],
      };
      if (!list.contains(jsonEncode(musicMap))) {
        list.insert(0, jsonEncode(musicMap));
      } else {
        list.remove(jsonEncode(musicMap));
      }
      await SpUtil.setStringList(PublicKeys.collectMusic, list);

      ///********************************end************************************
      isLike = !isLike;
      notifyListeners();
    }
  }

  ///获取收藏
  Future<void> initGetCollect(List songDetails) async {
    if (songDetails.isNotEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        List<String> list = SpUtil.getStringList(PublicKeys.collectMusic) ?? [];
        Map musicMap = {
          PublicKeys.songmid: songDetails[0],
          PublicKeys.albumMid: songDetails[1].length > 0 ? songDetails[1] : "",
          PublicKeys.songName: songDetails[2],
          PublicKeys.singer: songDetails[3],
        };
        list.contains(jsonEncode(musicMap)) ? isLike = true : isLike = false;
        notifyListeners();
      });
    }
  }

  ///下一首
  Future<void> preAndNextSong({bool isPre = false}) async {
    List<String> historyList = SpUtil.getStringList(PublicKeys.playHistory) ?? [];
    int index = 0;
    List<Map> list = [];
    if (historyList.isNotEmpty) {
      for (var element in historyList) {
        list.add(jsonDecode(element));
      }
      for (; index < list.length; index++) {
        if (list[index]["songmid"] == AppUtils.getContext().read<PlayBarViewModel>().playDetails[0]) {
          await nextSong(index, list, isPre: isPre);

          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            // initRecord();
            if (AppUtils.getContext().read<PlayBarViewModel>().isPlay) {
              animationC?.forward();
              recordC?.forward();
            }
            AppUtils.getContext().read<PlayBarViewModel>().updatePlayDetails();
            getLyric();
            updatePaletteGenerator();
            initGetCollect(AppUtils.getContext().read<PlayBarViewModel>().playDetails);
            getIsDownload();
            getCommentList();
            page = 0;
            notifyListeners();
          });
          break;
        }
      }
    }
  }

  Future<void> nextSong(int index, List list, {bool isPre = false}) async {
    if (!isPre) {
      if (index + 1 == list.length) {
        await AppUtils.getContext().read<SearchViewModel>().getMusicVKey(
              AppUtils.getContext(),
              list[0]["albumMid"],
              list[0]["songmid"],
              list[0]["songName"],
              list[0]["singer"],
              list[0]["topid"],
            );
      } else {
        await AppUtils.getContext().read<SearchViewModel>().getMusicVKey(
              AppUtils.getContext(),
              list[index + 1]["albumMid"],
              list[index + 1]["songmid"],
              list[index + 1]["songName"],
              list[index + 1]["singer"],
              list[index + 1]["topid"],
            );
      }
    } else {
      if (index == 0) {
        await AppUtils.getContext().read<SearchViewModel>().getMusicVKey(
              AppUtils.getContext(),
              list[list.length - 1]["albumMid"],
              list[list.length - 1]["songmid"],
              list[list.length - 1]["songName"],
              list[list.length - 1]["singer"],
              list[list.length - 1]["topid"],
            );
      } else {
        await AppUtils.getContext().read<SearchViewModel>().getMusicVKey(
              AppUtils.getContext(),
              list[index - 1]["albumMid"],
              list[index - 1]["songmid"],
              list[index - 1]["songName"],
              list[index - 1]["singer"],
              list[index - 1]["topid"],
            );
      }
    }
  }

  ///下载歌曲
  Future<bool> downloadSong() async {
    if (Platform.isAndroid) {
      await Permission.storage.isGranted;
      // print(await Permission.storage.isGranted);
      if (await Permission.storage.request().isPermanentlyDenied) {
        openAppSettings();
      }
    }

    // await NativeUtil.getPermission();
    if (Platform.isIOS) await Permission.photos.request().isGranted;
    if (!await getIsDownload(isCheck: true)) {
      if (AppUtils.getContext().read<PlayBarViewModel>().playDetails.isNotEmpty) {
        String downloadUrl =
            await DownloadRequest.downloadSong(AppUtils.getContext().read<PlayBarViewModel>().playDetails[0]);
        Dio dio = Dio();

        ///临时文件
        Directory dir = await getTemporaryDirectory();
        String savePath = '';
        if (Platform.isAndroid) {
          savePath =
              "${PublicKeys.musicRoot}${AppUtils.getContext().read<PlayBarViewModel>().playDetails[2].replaceAll("/", "\\")} - ${AppUtils.getContext().read<PlayBarViewModel>().playDetails[3].replaceAll("/", "\\")}.mp3";
        }
        if (Platform.isIOS) {
          savePath =
              "${dir.path}/music/${PublicKeys.musicRoot}${AppUtils.getContext().read<PlayBarViewModel>().playDetails[2].replaceAll("/", "\\")} - ${AppUtils.getContext().read<PlayBarViewModel>().playDetails[3].replaceAll("/", "\\")}.mp3";
        }

        await dio.download(downloadUrl, savePath, onReceiveProgress: (int count, int total) {
          downloadProgress = ((count / total) * 100).toInt();
          if (downloadProgress == 100) {
            Toast.showBottomToast("下载完成");
            getIsDownload();
          }
          notifyListeners();
        }).catchError((e) {
          Toast.showBottomToast("下载错误\n$e");
          debugPrint("下载错误$e");
        }).whenComplete(() => getIsDownload);
      }
    }
    return getIsDownload();
  }

  Future<bool> getIsDownload({bool isCheck = false}) async {
    if (AppUtils.getContext().read<PlayBarViewModel>().playDetails.isNotEmpty) {
      Directory dir = await getTemporaryDirectory();
      File file = Platform.isAndroid
          ? File(
              "${PublicKeys.musicRoot}${AppUtils.getContext().read<PlayBarViewModel>().playDetails[2].replaceAll("/", "\\")} - ${AppUtils.getContext().read<PlayBarViewModel>().playDetails[3].replaceAll("/", "\\")}.mp3")
          : File(
              "${dir.path}/music/${PublicKeys.musicRoot}${AppUtils.getContext().read<PlayBarViewModel>().playDetails[2].replaceAll("/", "\\")} - ${AppUtils.getContext().read<PlayBarViewModel>().playDetails[3].replaceAll("/", "\\")}.mp3");

      if (await file.exists()) {
        isDownload = true;
        if (isCheck) Toast.showBottomToast("已下载");
      } else {
        isDownload = false;
      }
      notifyListeners();
    }
    return isDownload;
  }

  ///分享歌曲
  Future<void> shareMusic() async {
    if (AppUtils.getContext().read<PlayBarViewModel>().playDetails.isNotEmpty) {
      Directory dir = await getTemporaryDirectory();
      File file = Platform.isAndroid
          ? File(
              "${PublicKeys.musicRoot}${AppUtils.getContext().read<PlayBarViewModel>().playDetails[2].replaceAll("/", "\\")} - ${AppUtils.getContext().read<PlayBarViewModel>().playDetails[3].replaceAll("/", "\\")}.mp3")
          : File(
              "${dir.path}/music/${PublicKeys.musicRoot}${AppUtils.getContext().read<PlayBarViewModel>().playDetails[2].replaceAll("/", "\\")} - ${AppUtils.getContext().read<PlayBarViewModel>().playDetails[3].replaceAll("/", "\\")}.mp3");

      if (await file.exists()) {
        ShareExtend.share(file.path, "file");
      } else {
        downloadSong().then((value) async {
          if (value) await ShareExtend.share(file.path, "file");
        });
      }
    }
  }

  ///歌曲弹幕
  Future<void> setBulletChat() async {
    if (AppUtils.getContext().read<PlayBarViewModel>().playDetails.isNotEmpty) {
      isBulletChat = !isBulletChat;
      if (isBulletChat) {
        getCommentList();
        timer2 = Timer.periodic(const Duration(milliseconds: 4000), (timer) {
          if (clModel!.comment?.commentlist?[index].avatarurl != null) {
            if (index == 24) {
              index = 0;
              page++;
              getCommentList();
            } else {
              Toast.showBulletChat(
                "${clModel!.comment?.commentlist?[index].avatarurl}",
                "${clModel!.comment?.commentlist?[index].rootcommentcontent}",
              );
              index++;
            }
          } else {
            getCommentList();
          }
        });
      } else {
        timer2?.cancel();
      }
      notifyListeners();
    } else {
      Toast.showBotToast("无播放歌曲");
    }
  }

  void getCommentList() async {
    clModel = (await CommentListRequest.getCommentList(
      AppUtils.getContext().read<PlayBarViewModel>().playDetails[4],
      page: page,
    ))!;
  }
}
