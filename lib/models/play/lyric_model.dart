import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class LyricRequest {
  static Future<List> getLyric(String songmid) async {
    List<String> lyrics = [];
    String url =
        "https://c.y.qq.com/lyric/fcgi-bin/fcg_query_lyric_new.fcg?songmid=$songmid&format=json";
    var response = await BaseRequest().toGet(
      url,
      options:
          Options(headers: {"Referer": "https://y.qq.com/portal/player.html"}),
    );
    LyricModel lyricModel = LyricModel.fromJson(response);
    if (lyricModel.lyric != null) {
      lyrics = Base64.decodeBase64(lyricModel.lyric.toString()).split("\n");
    }
    SpUtil.setStringList(PublicKeys.lyrics, lyrics);
    return lyrics;
  }
}

class LyricModel {
  int? retcode;
  int? code;
  int? subcode;
  String? lyric;
  String? trans;

  LyricModel({this.retcode, this.code, this.subcode, this.lyric, this.trans});

  LyricModel.fromJson(Map<String, dynamic> json) {
    retcode = json['retcode'];
    code = json['code'];
    subcode = json['subcode'];
    lyric = json['lyric'];
    trans = json['trans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['retcode'] = retcode;
    data['code'] = code;
    data['subcode'] = subcode;
    data['lyric'] = lyric;
    data['trans'] = trans;
    return data;
  }
}
