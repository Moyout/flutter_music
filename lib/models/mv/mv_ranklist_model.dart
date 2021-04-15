import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class MvRankListRequest {
  static Future<MvRankListModel?> getMvRankList() async {
    String map =
        '{"comm":{"ct":24,"cv":0},"request":{"method":"get_video_rank_list","param":{"rank_type":0,"area_type":0,"required":["vid","name","singers","cover_pic","pubdate"]},"module":"video.VideoRankServer"}}';
    String url = 'https://u.y.qq.com/cgi-bin/musicu.fcg?format=json&data=$map';
    var date = await BaseRequest().toGet("$url", options: Options(responseType: ResponseType.plain));
    if (date != null) {
      MvRankListModel mrlModel = MvRankListModel.fromJson(date);
      return mrlModel;
    }
    return null;
  }
}

class MvRankListModel {
  int? code;
  int? ts;
  int? startTs;
  Request? request;

  MvRankListModel({this.code, this.ts, this.startTs, this.request});

  MvRankListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    ts = json['ts'];
    startTs = json['start_ts'];
    request = json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['ts'] = this.ts;
    data['start_ts'] = this.startTs;
    if (this.request != null) {
      data['request'] = this.request?.toJson();
    }
    return data;
  }
}

class Request {
  int? code;
  Data? data;

  Request({this.code, this.data});

  Request.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? lastUpdate;
  List<RankList>? rankList;

  Data({this.lastUpdate, this.rankList});

  Data.fromJson(Map<String, dynamic> json) {
    lastUpdate = json['last_update'];
    if (json['rank_list'] != null) {
      rankList = [];
      json['rank_list'].forEach((v) {
        rankList?.add(new RankList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_update'] = this.lastUpdate;
    if (this.rankList != null) {
      data['rank_list'] = this.rankList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankList {
  Medal? medal;
  RankData? rankData;
  VideoInfo? videoInfo;

  RankList({this.medal, this.rankData, this.videoInfo});

  RankList.fromJson(Map<String, dynamic> json) {
    medal = json['medal'] != null ? new Medal.fromJson(json['medal']) : null;
    rankData = json['rank_data'] != null ? new RankData.fromJson(json['rank_data']) : null;
    videoInfo = json['video_info'] != null ? new VideoInfo.fromJson(json['video_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medal != null) {
      data['medal'] = this.medal?.toJson();
    }
    if (this.rankData != null) {
      data['rank_data'] = this.rankData?.toJson();
    }
    if (this.videoInfo != null) {
      data['video_info'] = this.videoInfo?.toJson();
    }
    return data;
  }
}

class Medal {
  Basic? basic;
  int? isTop;
  int? medalId;
  Record? record;

  Medal({this.basic, this.isTop, this.medalId, this.record});

  Medal.fromJson(Map<String, dynamic> json) {
    basic = json['basic'] != null ? new Basic.fromJson(json['basic']) : null;
    isTop = json['is_top'];
    medalId = json['medal_id'];
    record = json['record'] != null ? new Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basic != null) {
      data['basic'] = this.basic?.toJson();
    }
    data['is_top'] = this.isTop;
    data['medal_id'] = this.medalId;
    if (this.record != null) {
      data['record'] = this.record?.toJson();
    }
    return data;
  }
}

class Basic {
  String? name;
  String? picUrl;
  int? threshold;

  Basic({this.name, this.picUrl, this.threshold});

  Basic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    picUrl = json['pic_url'];
    threshold = json['threshold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pic_url'] = this.picUrl;
    data['threshold'] = this.threshold;
    return data;
  }
}

class Record {
  int? costTimeS;
  int? gid;
  String? gmid;
  int? medalId;
  String? name;
  List<Null>? singers;

  Record({this.costTimeS, this.gid, this.gmid, this.medalId, this.name, this.singers});

  Record.fromJson(Map<String, dynamic> json) {
    costTimeS = json['cost_time_s'];
    gid = json['gid'];
    gmid = json['gmid'];
    medalId = json['medal_id'];
    name = json['name'];
    if (json['singers'] != null) {
      singers = [];
      json['singers'].forEach((v) {
        singers?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost_time_s'] = this.costTimeS;
    data['gid'] = this.gid;
    data['gmid'] = this.gmid;
    data['medal_id'] = this.medalId;
    data['name'] = this.name;
    if (this.singers != null) {
      data['singers'] = this.singers?.map((v) => v).toList();
    }
    return data;
  }
}

class RankData {
  int? newFlag;
  int? rank;
  int? totalPlay;
  int? trend;
  int? weekPlay;

  RankData({this.newFlag, this.rank, this.totalPlay, this.trend, this.weekPlay});

  RankData.fromJson(Map<String, dynamic> json) {
    newFlag = json['new_flag'];
    rank = json['rank'];
    totalPlay = json['total_play'];
    trend = json['trend'];
    weekPlay = json['week_play'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_flag'] = this.newFlag;
    data['rank'] = this.rank;
    data['total_play'] = this.totalPlay;
    data['trend'] = this.trend;
    data['week_play'] = this.weekPlay;
    return data;
  }
}

class VideoInfo {
  String? coverPic;
  String? name;
  int? pubdate;
  List<Singers>? singers;
  String? vid;

  VideoInfo({this.coverPic, this.name, this.pubdate, this.singers, this.vid});

  VideoInfo.fromJson(Map<String, dynamic> json) {
    coverPic = json['cover_pic'];
    name = json['name'];
    pubdate = json['pubdate'];
    if (json['singers'] != null) {
      singers = [];
      json['singers'].forEach((v) {
        singers?.add(new Singers.fromJson(v));
      });
    }
    vid = json['vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover_pic'] = this.coverPic;
    data['name'] = this.name;
    data['pubdate'] = this.pubdate;
    if (this.singers != null) {
      data['singers'] = this.singers?.map((v) => v.toJson()).toList();
    }
    data['vid'] = this.vid;
    return data;
  }
}

class Singers {
  int? id;
  String? mid;
  String? name;
  String? picMid;
  String? picurl;

  Singers({this.id, this.mid, this.name, this.picMid, this.picurl});

  Singers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    name = json['name'];
    picMid = json['pic_mid'];
    picurl = json['picurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['pic_mid'] = this.picMid;
    data['picurl'] = this.picurl;
    return data;
  }
}
