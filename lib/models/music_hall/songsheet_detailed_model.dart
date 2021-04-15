import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class SongSheetDetailedRequest {
  static Future<SongSheetDetailedModel?> getSongSheetList(int id) async {
    String url =
        'https://c.y.qq.com/qzone/fcg-bin/fcg_ucc_getcdinfo_byids_cp.fcg?type=1&json=1&utf8=1&onlysong=0&new_format=1&disstid=$id&format=json&notice=0&song_begin=0&song_num=20';
    var response = await BaseRequest().toGet(
      url,
      options: Options(headers: {"referer": "https://y.qq.com/"}),
    );
    if (response!=null) {
      SongSheetDetailedModel ssdModel = SongSheetDetailedModel.fromJson(response);
      return ssdModel;
    }
    return null;
  }
}

class SongSheetDetailedModel {
  int? code;
  int? subcode;
  int? accessedPlazaCache;
  int? accessedFavbase;
  String? login;
  int? cdnum;
  List<Cdlist>? cdlist;
  int? realcdnum;

  SongSheetDetailedModel({this.code, this.subcode, this.accessedPlazaCache, this.accessedFavbase, this.login, this.cdnum, this.cdlist, this.realcdnum});

  SongSheetDetailedModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    subcode = json['subcode'];
    accessedPlazaCache = json['accessed_plaza_cache'];
    accessedFavbase = json['accessed_favbase'];
    login = json['login'];
    cdnum = json['cdnum'];
    if (json['cdlist'] != null) {
      cdlist = [];
      json['cdlist'].forEach((v) { cdlist?.add(new Cdlist.fromJson(v)); });
    }
    realcdnum = json['realcdnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['subcode'] = this.subcode;
    data['accessed_plaza_cache'] = this.accessedPlazaCache;
    data['accessed_favbase'] = this.accessedFavbase;
    data['login'] = this.login;
    data['cdnum'] = this.cdnum;
    if (this.cdlist != null) {
      data['cdlist'] = this.cdlist?.map((v) => v.toJson()).toList();
    }
    data['realcdnum'] = this.realcdnum;
    return data;
  }
}

class Cdlist {
  String? disstid;
  int? dirShow;
  int? owndir;
  int? dirid;
  String? coveradurl;
  int? dissid;
  String? login;
  String? uin;
  String? encryptUin;
  String? dissname;
  String? logo;
  String? picMid;
  String? albumPicMid;
  int? picDpi;
  int? isAd;
  String? desc;
  int? ctime;
  int? mtime;
  String? headurl;
  String? ifpicurl;
  String? nick;
  String? nickname;
  int? type;
  int? singerid;
  String? singermid;
  int? isvip;
  int? isdj;
  List<Tags>? tags;
  int? songnum;
  String? songids;
  String? songtypes;
  int? disstype;
  String? dirPicUrl2;
  int? songUpdateTime;
  int? songUpdateNum;
  int? totalSongNum;
  int? songBegin;
  int? curSongNum;
  List<Songlist>? songlist;
  int? visitnum;
  int? cmtnum;
  int? buynum;
  String? scoreavage;
  int? scoreusercount;

  Cdlist({this.disstid, this.dirShow, this.owndir, this.dirid, this.coveradurl, this.dissid, this.login, this.uin, this.encryptUin, this.dissname, this.logo, this.picMid, this.albumPicMid, this.picDpi, this.isAd, this.desc, this.ctime, this.mtime, this.headurl, this.ifpicurl, this.nick, this.nickname, this.type, this.singerid, this.singermid, this.isvip, this.isdj, this.tags, this.songnum, this.songids, this.songtypes, this.disstype, this.dirPicUrl2, this.songUpdateTime, this.songUpdateNum, this.totalSongNum, this.songBegin, this.curSongNum, this.songlist, this.visitnum, this.cmtnum, this.buynum, this.scoreavage, this.scoreusercount});

  Cdlist.fromJson(Map<String, dynamic> json) {
    disstid = json['disstid'];
    dirShow = json['dir_show'];
    owndir = json['owndir'];
    dirid = json['dirid'];
    coveradurl = json['coveradurl'];
    dissid = json['dissid'];
    login = json['login'];
    uin = json['uin'];
    encryptUin = json['encrypt_uin'];
    dissname = json['dissname'];
    logo = json['logo'];
    picMid = json['pic_mid'];
    albumPicMid = json['album_pic_mid'];
    picDpi = json['pic_dpi'];
    isAd = json['isAd'];
    desc = json['desc'];
    ctime = json['ctime'];
    mtime = json['mtime'];
    headurl = json['headurl'];
    ifpicurl = json['ifpicurl'];
    nick = json['nick'];
    nickname = json['nickname'];
    type = json['type'];
    singerid = json['singerid'];
    singermid = json['singermid'];
    isvip = json['isvip'];
    isdj = json['isdj'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) { tags?.add(new Tags.fromJson(v)); });
    }
    songnum = json['songnum'];
    songids = json['songids'];
    songtypes = json['songtypes'];
    disstype = json['disstype'];
    dirPicUrl2 = json['dir_pic_url2'];
    songUpdateTime = json['song_update_time'];
    songUpdateNum = json['song_update_num'];
    totalSongNum = json['total_song_num'];
    songBegin = json['song_begin'];
    curSongNum = json['cur_song_num'];
    if (json['songlist'] != null) {
      songlist = [];
      json['songlist'].forEach((v) { songlist?.add(new Songlist.fromJson(v)); });
    }
    visitnum = json['visitnum'];
    cmtnum = json['cmtnum'];
    buynum = json['buynum'];
    scoreavage = json['scoreavage'];
    scoreusercount = json['scoreusercount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disstid'] = this.disstid;
    data['dir_show'] = this.dirShow;
    data['owndir'] = this.owndir;
    data['dirid'] = this.dirid;
    data['coveradurl'] = this.coveradurl;
    data['dissid'] = this.dissid;
    data['login'] = this.login;
    data['uin'] = this.uin;
    data['encrypt_uin'] = this.encryptUin;
    data['dissname'] = this.dissname;
    data['logo'] = this.logo;
    data['pic_mid'] = this.picMid;
    data['album_pic_mid'] = this.albumPicMid;
    data['pic_dpi'] = this.picDpi;
    data['isAd'] = this.isAd;
    data['desc'] = this.desc;
    data['ctime'] = this.ctime;
    data['mtime'] = this.mtime;
    data['headurl'] = this.headurl;
    data['ifpicurl'] = this.ifpicurl;
    data['nick'] = this.nick;
    data['nickname'] = this.nickname;
    data['type'] = this.type;
    data['singerid'] = this.singerid;
    data['singermid'] = this.singermid;
    data['isvip'] = this.isvip;
    data['isdj'] = this.isdj;
    if (this.tags != null) {
      data['tags'] = this.tags?.map((v) => v.toJson()).toList();
    }
    data['songnum'] = this.songnum;
    data['songids'] = this.songids;
    data['songtypes'] = this.songtypes;
    data['disstype'] = this.disstype;
    data['dir_pic_url2'] = this.dirPicUrl2;
    data['song_update_time'] = this.songUpdateTime;
    data['song_update_num'] = this.songUpdateNum;
    data['total_song_num'] = this.totalSongNum;
    data['song_begin'] = this.songBegin;
    data['cur_song_num'] = this.curSongNum;
    if (this.songlist != null) {
      data['songlist'] = this.songlist?.map((v) => v.toJson()).toList();
    }
    data['visitnum'] = this.visitnum;
    data['cmtnum'] = this.cmtnum;
    data['buynum'] = this.buynum;
    data['scoreavage'] = this.scoreavage;
    data['scoreusercount'] = this.scoreusercount;
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  int? pid;

  Tags({this.id, this.name, this.pid});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pid'] = this.pid;
    return data;
  }
}

class Songlist {
  int? id;
  int? type;
  int? songtype;
  String? mid;
  String? name;
  String? title;
  String? subtitle;
  int? interval;
  int? isonly;
  int? language;
  int? genre;
  int? indexCd;
  int? indexAlbum;
  int? status;
  int? fnote;
  String? url;
  String? timePublic;
  int? tid;
  int? sa;
  int? ov;
  List<Singer>? singer;
  Album? album;
  Mv? mv;
  Ksong? ksong;
  File? file;
  Volume? volume;
  Pay? pay;
  Action? action;

  Songlist({this.id, this.type, this.songtype, this.mid, this.name, this.title, this.subtitle, this.interval, this.isonly, this.language, this.genre, this.indexCd, this.indexAlbum, this.status, this.fnote, this.url, this.timePublic, this.tid, this.sa, this.ov, this.singer, this.album, this.mv, this.ksong, this.file, this.volume, this.pay, this.action});

  Songlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    songtype = json['songtype'];
    mid = json['mid'];
    name = json['name'];
    title = json['title'];
    subtitle = json['subtitle'];
    interval = json['interval'];
    isonly = json['isonly'];
    language = json['language'];
    genre = json['genre'];
    indexCd = json['index_cd'];
    indexAlbum = json['index_album'];
    status = json['status'];
    fnote = json['fnote'];
    url = json['url'];
    timePublic = json['time_public'];
    tid = json['tid'];
    sa = json['sa'];
    ov = json['ov'];
    if (json['singer'] != null) {
      singer = [];
      json['singer'].forEach((v) { singer?.add(new Singer.fromJson(v)); });
    }
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    mv = json['mv'] != null ? new Mv.fromJson(json['mv']) : null;
    ksong = json['ksong'] != null ? new Ksong.fromJson(json['ksong']) : null;
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    volume = json['volume'] != null ? new Volume.fromJson(json['volume']) : null;
    pay = json['pay'] != null ? new Pay.fromJson(json['pay']) : null;
    action = json['action'] != null ? new Action.fromJson(json['action']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['songtype'] = this.songtype;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['interval'] = this.interval;
    data['isonly'] = this.isonly;
    data['language'] = this.language;
    data['genre'] = this.genre;
    data['index_cd'] = this.indexCd;
    data['index_album'] = this.indexAlbum;
    data['status'] = this.status;
    data['fnote'] = this.fnote;
    data['url'] = this.url;
    data['time_public'] = this.timePublic;
    data['tid'] = this.tid;
    data['sa'] = this.sa;
    data['ov'] = this.ov;
    if (this.singer != null) {
      data['singer'] = this.singer?.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album?.toJson();
    }
    if (this.mv != null) {
      data['mv'] = this.mv?.toJson();
    }
    if (this.ksong != null) {
      data['ksong'] = this.ksong?.toJson();
    }
    if (this.file != null) {
      data['file'] = this.file?.toJson();
    }
    if (this.volume != null) {
      data['volume'] = this.volume?.toJson();
    }
    if (this.pay != null) {
      data['pay'] = this.pay?.toJson();
    }
    if (this.action != null) {
      data['action'] = this.action?.toJson();
    }
    return data;
  }
}

class Singer {
  int? id;
  String? mid;
  String? name;
  String? title;

  Singer({this.id, this.mid, this.name, this.title});

  Singer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    name = json['name'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['title'] = this.title;
    return data;
  }
}

class Album {
  int? id;
  String? mid;
  String? pmid;
  String? name;
  String? title;
  String? subtitle;

  Album({this.id, this.mid, this.pmid, this.name, this.title, this.subtitle});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    pmid = json['pmid'];
    name = json['name'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['pmid'] = this.pmid;
    data['name'] = this.name;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    return data;
  }
}

class Mv {
  int? id;
  String? vid;

  Mv({this.id, this.vid});

  Mv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vid = json['vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vid'] = this.vid;
    return data;
  }
}

class Ksong {
  int? id;
  String? mid;

  Ksong({this.id, this.mid});

  Ksong.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    return data;
  }
}

class File {
  String? mediaMid;
  int? sizeTry;
  int? b30s;
  int? e30s;
  int? tryBegin;
  int? tryEnd;
  int? size24aac;
  int? size48aac;
  int? size96aac;
  int? size192aac;
  int? size192ogg;
  int? size128mp3;
  int? size320mp3;
  int? sizeAac;
  int? sizeOgg;
  int? size128;
  int? size320;
  int? sizeApe;
  int? sizeFlac;
  int? sizeDts;

  File({this.mediaMid, this.sizeTry, this.b30s, this.e30s, this.tryBegin, this.tryEnd, this.size24aac, this.size48aac, this.size96aac, this.size192aac, this.size192ogg, this.size128mp3, this.size320mp3, this.sizeAac, this.sizeOgg, this.size128, this.size320, this.sizeApe, this.sizeFlac, this.sizeDts});

  File.fromJson(Map<String, dynamic> json) {
    mediaMid = json['media_mid'];
    sizeTry = json['size_try'];
    b30s = json['b_30s'];
    e30s = json['e_30s'];
    tryBegin = json['try_begin'];
    tryEnd = json['try_end'];
    size24aac = json['size_24aac'];
    size48aac = json['size_48aac'];
    size96aac = json['size_96aac'];
    size192aac = json['size_192aac'];
    size192ogg = json['size_192ogg'];
    size128mp3 = json['size_128mp3'];
    size320mp3 = json['size_320mp3'];
    sizeAac = json['size_aac'];
    sizeOgg = json['size_ogg'];
    size128 = json['size_128'];
    size320 = json['size_320'];
    sizeApe = json['size_ape'];
    sizeFlac = json['size_flac'];
    sizeDts = json['size_dts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_mid'] = this.mediaMid;
    data['size_try'] = this.sizeTry;
    data['b_30s'] = this.b30s;
    data['e_30s'] = this.e30s;
    data['try_begin'] = this.tryBegin;
    data['try_end'] = this.tryEnd;
    data['size_24aac'] = this.size24aac;
    data['size_48aac'] = this.size48aac;
    data['size_96aac'] = this.size96aac;
    data['size_192aac'] = this.size192aac;
    data['size_192ogg'] = this.size192ogg;
    data['size_128mp3'] = this.size128mp3;
    data['size_320mp3'] = this.size320mp3;
    data['size_aac'] = this.sizeAac;
    data['size_ogg'] = this.sizeOgg;
    data['size_128'] = this.size128;
    data['size_320'] = this.size320;
    data['size_ape'] = this.sizeApe;
    data['size_flac'] = this.sizeFlac;
    data['size_dts'] = this.sizeDts;
    return data;
  }
}

class Volume {
  String? gain;
  String? peak;
  String? lra;

  Volume({this.gain, this.peak, this.lra});

  Volume.fromJson(Map<String, dynamic> json) {
    gain = json['gain'].toString();
    peak = json['peak'].toString();
    lra = json['lra'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gain'] = this.gain;
    data['peak'] = this.peak;
    data['lra'] = this.lra;
    return data;
  }
}

class Pay {
  int? payMonth;
  int? priceTrack;
  int? priceAlbum;
  int? payPlay;
  int? payDown;
  int? payStatus;
  int? timeFree;

  Pay({this.payMonth, this.priceTrack, this.priceAlbum, this.payPlay, this.payDown, this.payStatus, this.timeFree});

  Pay.fromJson(Map<String, dynamic> json) {
    payMonth = json['pay_month'];
    priceTrack = json['price_track'];
    priceAlbum = json['price_album'];
    payPlay = json['pay_play'];
    payDown = json['pay_down'];
    payStatus = json['pay_status'];
    timeFree = json['time_free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_month'] = this.payMonth;
    data['price_track'] = this.priceTrack;
    data['price_album'] = this.priceAlbum;
    data['pay_play'] = this.payPlay;
    data['pay_down'] = this.payDown;
    data['pay_status'] = this.payStatus;
    data['time_free'] = this.timeFree;
    return data;
  }
}

class Action {
  int? switch1;
  int? msgid;
  int? msgpay;
  int? alert;
  int? icons;

  Action({this.switch1, this.msgid, this.msgpay, this.alert, this.icons});

  Action.fromJson(Map<String, dynamic> json) {
    switch1 = json['switch'];
    msgid = json['msgid'];
    msgpay = json['msgpay'];
    alert = json['alert'];
    icons = json['icons'];
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['switch'] = this.switch1;
    data['msgid'] = this.msgid;
    data['msgpay'] = this.msgpay;
    data['alert'] = this.alert;
    data['icons'] = this.icons;
    return data;
    }
}
