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
      json['cdlist'].forEach((v) { cdlist?.add(Cdlist.fromJson(v)); });
    }
    realcdnum = json['realcdnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['subcode'] = subcode;
    data['accessed_plaza_cache'] = accessedPlazaCache;
    data['accessed_favbase'] = accessedFavbase;
    data['login'] = login;
    data['cdnum'] = cdnum;
    if (cdlist != null) {
      data['cdlist'] = cdlist?.map((v) => v.toJson()).toList();
    }
    data['realcdnum'] = realcdnum;
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
      json['tags'].forEach((v) { tags?.add(Tags.fromJson(v)); });
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
      json['songlist'].forEach((v) { songlist?.add(Songlist.fromJson(v)); });
    }
    visitnum = json['visitnum'];
    cmtnum = json['cmtnum'];
    buynum = json['buynum'];
    scoreavage = json['scoreavage'];
    scoreusercount = json['scoreusercount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disstid'] = disstid;
    data['dir_show'] = dirShow;
    data['owndir'] = owndir;
    data['dirid'] = dirid;
    data['coveradurl'] = coveradurl;
    data['dissid'] = dissid;
    data['login'] = login;
    data['uin'] = uin;
    data['encrypt_uin'] = encryptUin;
    data['dissname'] = dissname;
    data['logo'] = logo;
    data['pic_mid'] = picMid;
    data['album_pic_mid'] = albumPicMid;
    data['pic_dpi'] = picDpi;
    data['isAd'] = isAd;
    data['desc'] = desc;
    data['ctime'] = ctime;
    data['mtime'] = mtime;
    data['headurl'] = headurl;
    data['ifpicurl'] = ifpicurl;
    data['nick'] = nick;
    data['nickname'] = nickname;
    data['type'] = type;
    data['singerid'] = singerid;
    data['singermid'] = singermid;
    data['isvip'] = isvip;
    data['isdj'] = isdj;
    if (tags != null) {
      data['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    data['songnum'] = songnum;
    data['songids'] = songids;
    data['songtypes'] = songtypes;
    data['disstype'] = disstype;
    data['dir_pic_url2'] = dirPicUrl2;
    data['song_update_time'] = songUpdateTime;
    data['song_update_num'] = songUpdateNum;
    data['total_song_num'] = totalSongNum;
    data['song_begin'] = songBegin;
    data['cur_song_num'] = curSongNum;
    if (songlist != null) {
      data['songlist'] = songlist?.map((v) => v.toJson()).toList();
    }
    data['visitnum'] = visitnum;
    data['cmtnum'] = cmtnum;
    data['buynum'] = buynum;
    data['scoreavage'] = scoreavage;
    data['scoreusercount'] = scoreusercount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pid'] = pid;
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
      json['singer'].forEach((v) { singer?.add(Singer.fromJson(v)); });
    }
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    mv = json['mv'] != null ? Mv.fromJson(json['mv']) : null;
    ksong = json['ksong'] != null ? Ksong.fromJson(json['ksong']) : null;
    file = json['file'] != null ? File.fromJson(json['file']) : null;
    volume = json['volume'] != null ? Volume.fromJson(json['volume']) : null;
    pay = json['pay'] != null ? Pay.fromJson(json['pay']) : null;
    action = json['action'] != null ? Action.fromJson(json['action']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['songtype'] = songtype;
    data['mid'] = mid;
    data['name'] = name;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['interval'] = interval;
    data['isonly'] = isonly;
    data['language'] = language;
    data['genre'] = genre;
    data['index_cd'] = indexCd;
    data['index_album'] = indexAlbum;
    data['status'] = status;
    data['fnote'] = fnote;
    data['url'] = url;
    data['time_public'] = timePublic;
    data['tid'] = tid;
    data['sa'] = sa;
    data['ov'] = ov;
    if (singer != null) {
      data['singer'] = singer?.map((v) => v.toJson()).toList();
    }
    if (album != null) {
      data['album'] = album?.toJson();
    }
    if (mv != null) {
      data['mv'] = mv?.toJson();
    }
    if (ksong != null) {
      data['ksong'] = ksong?.toJson();
    }
    if (file != null) {
      data['file'] = file?.toJson();
    }
    if (volume != null) {
      data['volume'] = volume?.toJson();
    }
    if (pay != null) {
      data['pay'] = pay?.toJson();
    }
    if (action != null) {
      data['action'] = action?.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mid'] = mid;
    data['name'] = name;
    data['title'] = title;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mid'] = mid;
    data['pmid'] = pmid;
    data['name'] = name;
    data['title'] = title;
    data['subtitle'] = subtitle;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vid'] = vid;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mid'] = mid;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_mid'] = mediaMid;
    data['size_try'] = sizeTry;
    data['b_30s'] = b30s;
    data['e_30s'] = e30s;
    data['try_begin'] = tryBegin;
    data['try_end'] = tryEnd;
    data['size_24aac'] = size24aac;
    data['size_48aac'] = size48aac;
    data['size_96aac'] = size96aac;
    data['size_192aac'] = size192aac;
    data['size_192ogg'] = size192ogg;
    data['size_128mp3'] = size128mp3;
    data['size_320mp3'] = size320mp3;
    data['size_aac'] = sizeAac;
    data['size_ogg'] = sizeOgg;
    data['size_128'] = size128;
    data['size_320'] = size320;
    data['size_ape'] = sizeApe;
    data['size_flac'] = sizeFlac;
    data['size_dts'] = sizeDts;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gain'] = gain;
    data['peak'] = peak;
    data['lra'] = lra;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pay_month'] = payMonth;
    data['price_track'] = priceTrack;
    data['price_album'] = priceAlbum;
    data['pay_play'] = payPlay;
    data['pay_down'] = payDown;
    data['pay_status'] = payStatus;
    data['time_free'] = timeFree;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['switch'] = switch1;
    data['msgid'] = msgid;
    data['msgpay'] = msgpay;
    data['alert'] = alert;
    data['icons'] = icons;
    return data;
    }
}
