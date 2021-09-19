import 'package:flutter_music/util/tools.dart';

class SearchMusicRequest {
  static Future<SearchMusicModel?> getSearchMusic(String songName,
      {int p = 1, int limit = 10}) async {
    var response = await BaseRequest().toGet(
      "https://c.y.qq.com/soso/fcgi-bin/client_search_cp?format=json&p=$p&n=$limit&w=$songName",
    );
    SearchMusicModel searchMusicModel = SearchMusicModel.fromJson(response);
    return searchMusicModel;
  }
}

class SearchMusicModel {
  int? code;
  Data? data;
  String? message;
  String? notice;
  int? subcode;
  int? time;
  String? tips;

  SearchMusicModel(
      {this.code,
      this.data,
      this.message,
      this.notice,
      this.subcode,
      this.time,
      this.tips});

  SearchMusicModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    notice = json['notice'];
    subcode = json['subcode'];
    time = json['time'];
    tips = json['tips'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = message;
    data['notice'] = notice;
    data['subcode'] = subcode;
    data['time'] = time;
    data['tips'] = tips;
    return data;
  }
}

class Data {
  String? keyword;
  int? priority;
  List? qc;
  Semantic? semantic;
  Song? song;
  int? tab;
  List<void>? taglist;
  int? totaltime;
  Zhida? zhida;

  Data(
      {this.keyword,
      this.priority,
      this.qc,
      this.semantic,
      this.song,
      this.tab,
      this.taglist,
      this.totaltime,
      this.zhida});

  Data.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    priority = json['priority'];
    if (json['qc'] != null) {
      qc = qc;
    }
    semantic = json['semantic'] != null
        ? Semantic.fromJson(json['semantic'])
        : null;
    song = json['song'] != null ? Song.fromJson(json['song']) : null;
    tab = json['tab'];
    if (json['taglist'] != null) {
      taglist = taglist;
    }
    totaltime = json['totaltime'];
    zhida = json['zhida'] != null ? Zhida.fromJson(json['zhida']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword;
    data['priority'] = priority;
    if (qc != null) {
      data['qc'] = qc?.map((v) => v.toJson()).toList();
    }
    if (semantic != null) {
      data['semantic'] = semantic?.toJson();
    }
    if (song != null) {
      data['song'] = song?.toJson();
    }
    data['tab'] = tab;
    if (taglist != null) {
      data['taglist'] = taglist;
    }
    data['totaltime'] = totaltime;
    if (zhida != null) {
      data['zhida'] = zhida?.toJson();
    }
    return data;
  }
}

class Semantic {
  int? curnum;
  int? curpage;
  List? list;
  int? totalnum;

  Semantic({this.curnum, this.curpage, this.list, this.totalnum});

  Semantic.fromJson(Map<String, dynamic> json) {
    curnum = json['curnum'];
    curpage = json['curpage'];
    if (json['list'] != null) {
      list?.clear();
      json['list'].forEach((v) {
        list?.add(Semantic.fromJson(v));
      });
    }
    totalnum = json['totalnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['curnum'] = curnum;
    data['curpage'] = curpage;
    if (list != null) {
      data['list'] = list?.map((v) => v.toJson()).toList();
    }
    data['totalnum'] = totalnum;
    return data;
  }
}

class Song {
  int? curnum;
  int? curpage;
  List<List1>? list;
  int? totalnum;

  Song({this.curnum, this.curpage, this.list, this.totalnum});

  Song.fromJson(Map<String, dynamic> json) {
    curnum = json['curnum'];
    curpage = json['curpage'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(List1.fromJson(v));
      });
    }
    totalnum = json['totalnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['curnum'] = curnum;
    data['curpage'] = curpage;
    if (list != null) {
      data['list'] = list?.map((v) => v.toJson()).toList();
    }
    data['totalnum'] = totalnum;
    return data;
  }
}

class List1 {
  int? albumid;
  String? albummid;
  String? albumname;
  String? albumnameHilight;
  int? alertid;
  int? belongCD;
  int? cdIdx;
  int? chinesesinger;
  String? docid;
  List<void>? grp;
  int? interval;
  int? isonly;
  String? lyric;
  String? lyricHilight;
  String? mediaMid;
  int? msgid;
  int? newStatus;
  int? nt;
  Pay? pay;
  Preview? preview;
  int? pubtime;
  int? pure;
  List<Singer?>? singer;
  int? size128;
  int? size320;
  int? sizeape;
  int? sizeflac;
  int? sizeogg;
  int? songid;
  String? songmid;
  String? songname;
  String? songnameHilight;
  String? strMediaMid;
  int? stream;
  int? switch1;
  int? t;
  int? tag;
  int? type;
  int? ver;
  String? vid;
  String? format;
  String? songurl;

  List1(
      {this.albumid,
      this.albummid,
      this.albumname,
      this.albumnameHilight,
      this.alertid,
      this.belongCD,
      this.cdIdx,
      this.chinesesinger,
      this.docid,
      this.grp,
      this.interval,
      this.isonly,
      this.lyric,
      this.lyricHilight,
      this.mediaMid,
      this.msgid,
      this.newStatus,
      this.nt,
      this.pay,
      this.preview,
      this.pubtime,
      this.pure,
      this.singer,
      this.size128,
      this.size320,
      this.sizeape,
      this.sizeflac,
      this.sizeogg,
      this.songid,
      this.songmid,
      this.songname,
      this.songnameHilight,
      this.strMediaMid,
      this.stream,
      this.switch1,
      this.t,
      this.tag,
      this.type,
      this.ver,
      this.vid,
      this.format,
      this.songurl});

  List1.fromJson(Map<String, dynamic> json) {
    albumid = json['albumid'];
    albummid = json['albummid'];
    albumname = json['albumname'];
    albumnameHilight = json['albumname_hilight'];
    alertid = json['alertid'];
    belongCD = json['belongCD'];
    cdIdx = json['cdIdx'];
    chinesesinger = json['chinesesinger'];
    docid = json['docid'];
    if (json['grp'] != null) {
      grp = grp;
    }
    interval = json['interval'];
    isonly = json['isonly'];
    lyric = json['lyric'];
    lyricHilight = json['lyric_hilight'];
    mediaMid = json['media_mid'];
    msgid = json['msgid'];
    newStatus = json['newStatus'];
    nt = json['nt'];
    pay = json['pay'] != null ? Pay.fromJson(json['pay']) : null;
    preview =
        json['preview'] != null ? Preview.fromJson(json['preview']) : null;
    pubtime = json['pubtime'];
    pure = json['pure'];
    if (json['singer'] != null) {
      singer = [];
      json['singer'].forEach((v) {
        singer?.add(Singer.fromJson(v));
      });
    }
    size128 = json['size128'];
    size320 = json['size320'];
    sizeape = json['sizeape'];
    sizeflac = json['sizeflac'];
    sizeogg = json['sizeogg'];
    songid = json['songid'];
    songmid = json['songmid'];
    songname = json['songname'];
    songnameHilight = json['songname_hilight'];
    strMediaMid = json['strMediaMid'];
    stream = json['stream'];
    switch1 = json['switch'];
    t = json['t'];
    tag = json['tag'];
    type = json['type'];
    ver = json['ver'];
    vid = json['vid'];
    format = json['format'];
    songurl = json['songurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumid'] = albumid;
    data['albummid'] = albummid;
    data['albumname'] = albumname;
    data['albumname_hilight'] = albumnameHilight;
    data['alertid'] = alertid;
    data['belongCD'] = belongCD;
    data['cdIdx'] = cdIdx;
    data['chinesesinger'] = chinesesinger;
    data['docid'] = docid;
    if (grp != null) {
      data['grp'] = grp;
    }
    data['interval'] = interval;
    data['isonly'] = isonly;
    data['lyric'] = lyric;
    data['lyric_hilight'] = lyricHilight;
    data['media_mid'] = mediaMid;
    data['msgid'] = msgid;
    data['newStatus'] = newStatus;
    data['nt'] = nt;
    if (pay != null) {
      data['pay'] = pay?.toJson();
    }
    if (preview != null) {
      data['preview'] = preview?.toJson();
    }
    data['pubtime'] = pubtime;
    data['pure'] = pure;
    if (singer != null) {
      data['singer'] = singer?.map((v) => v!.toJson()).toList();
    }
    data['size128'] = size128;
    data['size320'] = size320;
    data['sizeape'] = sizeape;
    data['sizeflac'] = sizeflac;
    data['sizeogg'] = sizeogg;
    data['songid'] = songid;
    data['songmid'] = songmid;
    data['songname'] = songname;
    data['songname_hilight'] = songnameHilight;
    data['strMediaMid'] = strMediaMid;
    data['stream'] = stream;
    data['switch'] = switch1;
    data['t'] = t;
    data['tag'] = tag;
    data['type'] = type;
    data['ver'] = ver;
    data['vid'] = vid;
    data['format'] = format;
    data['songurl'] = songurl;
    return data;
  }
}

class Pay {
  int? payalbum;
  int? payalbumprice;
  int? paydownload;
  int? payinfo;
  int? payplay;
  int? paytrackmouth;
  int? paytrackprice;

  Pay(
      {this.payalbum,
      this.payalbumprice,
      this.paydownload,
      this.payinfo,
      this.payplay,
      this.paytrackmouth,
      this.paytrackprice});

  Pay.fromJson(Map<String, dynamic> json) {
    payalbum = json['payalbum'];
    payalbumprice = json['payalbumprice'];
    paydownload = json['paydownload'];
    payinfo = json['payinfo'];
    payplay = json['payplay'];
    paytrackmouth = json['paytrackmouth'];
    paytrackprice = json['paytrackprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payalbum'] = payalbum;
    data['payalbumprice'] = payalbumprice;
    data['paydownload'] = paydownload;
    data['payinfo'] = payinfo;
    data['payplay'] = payplay;
    data['paytrackmouth'] = paytrackmouth;
    data['paytrackprice'] = paytrackprice;
    return data;
  }
}

class Preview {
  int? trybegin;
  int? tryend;
  int? trysize;

  Preview({this.trybegin, this.tryend, this.trysize});

  Preview.fromJson(Map<String, dynamic> json) {
    trybegin = json['trybegin'];
    tryend = json['tryend'];
    trysize = json['trysize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trybegin'] = trybegin;
    data['tryend'] = tryend;
    data['trysize'] = trysize;
    return data;
  }
}

class Singer {
  int? id;
  String? mid;
  String? name;
  String? nameHilight;

  Singer({this.id, this.mid, this.name, this.nameHilight});

  Singer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    name = json['name'];
    nameHilight = json['name_hilight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mid'] = mid;
    data['name'] = name;
    data['name_hilight'] = nameHilight;
    return data;
  }
}

class Zhida {
  int? chinesesinger;
  int? type;

  Zhida({this.chinesesinger, this.type});

  Zhida.fromJson(Map<String, dynamic> json) {
    chinesesinger = json['chinesesinger'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chinesesinger'] = chinesesinger;
    data['type'] = type;
    return data;
  }
}
