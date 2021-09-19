import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class RecommendSongSheetRequest {
  static Future<RecommendSongSheetModel?> getSongSheet() async {
    String map =
        '{"comm": {"ct": 24},"recomPlaylist": {"method":"get_hot_recommend","param":{"async":1,"cmd":2},"module":"playlist.HotRecommendServer"}}';
    String url = 'http://u.y.qq.com/cgi-bin/musicu.fcg?data=$map&format=json&platform=yqq.json';
    var response = await BaseRequest().toGet(url, options: Options(responseType: ResponseType.plain));
    if (response != null) {
      RecommendSongSheetModel rSSModel = RecommendSongSheetModel.fromJson(response);
      return rSSModel;
    }
    return null;
  }
}

class RecommendSongSheetModel {
  String? code;
  int? ts;
  int? startTs;
  RecomPlaylist? recomPlaylist;

  RecommendSongSheetModel({this.code = " ", this.ts, this.startTs, this.recomPlaylist});

  RecommendSongSheetModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    ts = json['ts'];
    startTs = json['start_ts'];
    recomPlaylist = json['recomPlaylist'] != null ? RecomPlaylist.fromJson(json['recomPlaylist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['ts'] = ts;
    data['start_ts'] = startTs;
    if (recomPlaylist != null) {
      data['recomPlaylist'] = recomPlaylist?.toJson();
    }
    return data;
  }
}

class RecomPlaylist {
  int? code;
  Data? data;

  RecomPlaylist({this.code, this.data});

  RecomPlaylist.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? page;
  List<VHot>? vHot;

  Data({this.page, this.vHot});

  Data.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['v_hot'] != null) {
      vHot = [];
      json['v_hot'].forEach((v) {
        vHot?.add(VHot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (vHot != null) {
      data['v_hot'] = vHot?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VHot {
  String? albumPicMid;
  int? contentId;
  String? cover;
  int? creator;
  String? edgeMark;
  int? id;
  bool? isDj;
  bool? isVip;
  String? jumpUrl;
  int? listenNum;
  String? picMid;
  String? rcmdcontent;
  String? rcmdtemplate;
  int? rcmdtype;
  int? singerid;
  String? title;
  String? tjreport;
  int? type;
  String? username;

  VHot(
      {this.albumPicMid,
      this.contentId,
      this.cover,
      this.creator,
      this.edgeMark,
      this.id,
      this.isDj,
      this.isVip,
      this.jumpUrl,
      this.listenNum,
      this.picMid,
      this.rcmdcontent,
      this.rcmdtemplate,
      this.rcmdtype,
      this.singerid,
      this.title,
      this.tjreport,
      this.type,
      this.username});

  VHot.fromJson(Map<String, dynamic> json) {
    albumPicMid = json['album_pic_mid'];
    contentId = json['content_id'];
    cover = json['cover'];
    creator = json['creator'];
    edgeMark = json['edge_mark'];
    id = json['id'];
    isDj = json['is_dj'];
    isVip = json['is_vip'];
    jumpUrl = json['jump_url'];
    listenNum = json['listen_num'];
    picMid = json['pic_mid'];
    rcmdcontent = json['rcmdcontent'];
    rcmdtemplate = json['rcmdtemplate'];
    rcmdtype = json['rcmdtype'];
    singerid = json['singerid'];
    title = json['title'];
    tjreport = json['tjreport'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['album_pic_mid'] = albumPicMid;
    data['content_id'] = contentId;
    data['cover'] = cover;
    data['creator'] = creator;
    data['edge_mark'] = edgeMark;
    data['id'] = id;
    data['is_dj'] = isDj;
    data['is_vip'] = isVip;
    data['jump_url'] = jumpUrl;
    data['listen_num'] = listenNum;
    data['pic_mid'] = picMid;
    data['rcmdcontent'] = rcmdcontent;
    data['rcmdtemplate'] = rcmdtemplate;
    data['rcmdtype'] = rcmdtype;
    data['singerid'] = singerid;
    data['title'] = title;
    data['tjreport'] = tjreport;
    data['type'] = type;
    data['username'] = username;
    return data;
  }
}
