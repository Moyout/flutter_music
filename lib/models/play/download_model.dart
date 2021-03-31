import 'dart:io';

import 'package:flutter_music/models/search/music_key_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadRequest {
  static Future<String> downloadSong(String songmid) async {
    MusicKeyModel musicKeyModel = (await MusicKeyRequest.getMusicVKey(songmid))!;
    if (musicKeyModel.req0!.data!.midurlinfo![0].purl!.length == 0) {
      Toast.showBotToast("暂不支持");
      return "";
    } else {
      if (Platform.isAndroid) await Permission.storage.request().isGranted;
      if (Platform.isIOS) await Permission.photos.request().isGranted;
      String _downloadUrl = "http://ws.stream.qqmusic.qq.com/" + musicKeyModel.req0!.data!.midurlinfo![0].purl!;
      return _downloadUrl;
    }
  }
}
