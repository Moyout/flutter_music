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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    notice = json['notice'];
    subcode = json['subcode'];
    time = json['time'];
    tips = json['tips'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = this.message;
    data['notice'] = this.notice;
    data['subcode'] = this.subcode;
    data['time'] = this.time;
    data['tips'] = this.tips;
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
  List<Null>? taglist;
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
      qc = this.qc;
    }
    semantic = json['semantic'] != null
        ? new Semantic.fromJson(json['semantic'])
        : null;
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
    tab = json['tab'];
    if (json['taglist'] != null) {
      taglist = this.taglist;
    }
    totaltime = json['totaltime'];
    zhida = json['zhida'] != null ? new Zhida.fromJson(json['zhida']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    data['priority'] = this.priority;
    if (this.qc != null) {
      data['qc'] = this.qc?.map((v) => v.toJson()).toList();
    }
    if (this.semantic != null) {
      data['semantic'] = this.semantic?.toJson();
    }
    if (this.song != null) {
      data['song'] = this.song?.toJson();
    }
    data['tab'] = this.tab;
    if (this.taglist != null) {
      data['taglist'] = this.taglist;
    }
    data['totaltime'] = this.totaltime;
    if (this.zhida != null) {
      data['zhida'] = this.zhida?.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curnum'] = this.curnum;
    data['curpage'] = this.curpage;
    if (this.list != null) {
      data['list'] = this.list?.map((v) => v.toJson()).toList();
    }
    data['totalnum'] = this.totalnum;
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
        list?.add(new List1.fromJson(v));
      });
    }
    totalnum = json['totalnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curnum'] = this.curnum;
    data['curpage'] = this.curpage;
    if (this.list != null) {
      data['list'] = this.list?.map((v) => v.toJson()).toList();
    }
    data['totalnum'] = this.totalnum;
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
  List<Null>? grp;
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
      grp = this.grp;
    }
    interval = json['interval'];
    isonly = json['isonly'];
    lyric = json['lyric'];
    lyricHilight = json['lyric_hilight'];
    mediaMid = json['media_mid'];
    msgid = json['msgid'];
    newStatus = json['newStatus'];
    nt = json['nt'];
    pay = json['pay'] != null ? new Pay.fromJson(json['pay']) : null;
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
    pubtime = json['pubtime'];
    pure = json['pure'];
    if (json['singer'] != null) {
      singer = [];
      json['singer'].forEach((v) {
        singer?.add(new Singer.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumid'] = this.albumid;
    data['albummid'] = this.albummid;
    data['albumname'] = this.albumname;
    data['albumname_hilight'] = this.albumnameHilight;
    data['alertid'] = this.alertid;
    data['belongCD'] = this.belongCD;
    data['cdIdx'] = this.cdIdx;
    data['chinesesinger'] = this.chinesesinger;
    data['docid'] = this.docid;
    if (this.grp != null) {
      data['grp'] = this.grp;
    }
    data['interval'] = this.interval;
    data['isonly'] = this.isonly;
    data['lyric'] = this.lyric;
    data['lyric_hilight'] = this.lyricHilight;
    data['media_mid'] = this.mediaMid;
    data['msgid'] = this.msgid;
    data['newStatus'] = this.newStatus;
    data['nt'] = this.nt;
    if (this.pay != null) {
      data['pay'] = this.pay?.toJson();
    }
    if (this.preview != null) {
      data['preview'] = this.preview?.toJson();
    }
    data['pubtime'] = this.pubtime;
    data['pure'] = this.pure;
    if (this.singer != null) {
      data['singer'] = this.singer?.map((v) => v!.toJson()).toList();
    }
    data['size128'] = this.size128;
    data['size320'] = this.size320;
    data['sizeape'] = this.sizeape;
    data['sizeflac'] = this.sizeflac;
    data['sizeogg'] = this.sizeogg;
    data['songid'] = this.songid;
    data['songmid'] = this.songmid;
    data['songname'] = this.songname;
    data['songname_hilight'] = this.songnameHilight;
    data['strMediaMid'] = this.strMediaMid;
    data['stream'] = this.stream;
    data['switch'] = this.switch1;
    data['t'] = this.t;
    data['tag'] = this.tag;
    data['type'] = this.type;
    data['ver'] = this.ver;
    data['vid'] = this.vid;
    data['format'] = this.format;
    data['songurl'] = this.songurl;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payalbum'] = this.payalbum;
    data['payalbumprice'] = this.payalbumprice;
    data['paydownload'] = this.paydownload;
    data['payinfo'] = this.payinfo;
    data['payplay'] = this.payplay;
    data['paytrackmouth'] = this.paytrackmouth;
    data['paytrackprice'] = this.paytrackprice;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trybegin'] = this.trybegin;
    data['tryend'] = this.tryend;
    data['trysize'] = this.trysize;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['name_hilight'] = this.nameHilight;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chinesesinger'] = this.chinesesinger;
    data['type'] = this.type;
    return data;
  }
}
