import 'package:flutter_music/util/tools.dart';

class HotMusicRequest {
  static Future<HotMusicModel?> getHotMusic() async {
    var date = await BaseRequest().toGet(
        "https://c.y.qq.com/v8/fcg-bin/fcg_v8_toplist_cp.fcg?format=json&type=top&topid=27");
    HotMusicModel hotMusicModel = HotMusicModel.fromJson(date);
    return hotMusicModel;
  }
}

class HotMusicModel {
  int? code;
  int? color;
  int? commentNum;
  int? curSongNum;
  String? date;
  String? dayOfYear;
  int? songBegin;
  List<Songlist>? songlist;
  Topinfo? topinfo;
  int? totalSongNum;
  String? updateTime;

  HotMusicModel(
      {this.code,
      this.color,
      this.commentNum,
      this.curSongNum,
      this.date,
      this.dayOfYear,
      this.songBegin,
      this.songlist,
      this.topinfo,
      this.totalSongNum,
      this.updateTime});

  HotMusicModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    color = json['color'];
    commentNum = json['comment_num'];
    curSongNum = json['cur_song_num'];
    date = json['date'];
    dayOfYear = json['day_of_year'];
    songBegin = json['song_begin'];
    if (json['songlist'] != null) {
      songlist = [];
      json['songlist'].forEach((v) {
        songlist?.add(new Songlist.fromJson(v));
      });
    }
    topinfo =
        json['topinfo'] != null ? new Topinfo.fromJson(json['topinfo']) : null;
    totalSongNum = json['total_song_num'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['color'] = this.color;
    data['comment_num'] = this.commentNum;
    data['cur_song_num'] = this.curSongNum;
    data['date'] = this.date;
    data['day_of_year'] = this.dayOfYear;
    data['song_begin'] = this.songBegin;
    if (this.songlist != null) {
      data['songlist'] = this.songlist?.map((v) => v.toJson()).toList();
    }
    if (this.topinfo != null) {
      data['topinfo'] = this.topinfo?.toJson();
    }
    data['total_song_num'] = this.totalSongNum;
    data['update_time'] = this.updateTime;
    return data;
  }
}

class Songlist {
  String? frankingValue;
  String? curCount;
  Data? data;
  String? inCount;
  String? oldCount;

  Songlist(
      {this.frankingValue,
      this.curCount,
      this.data,
      this.inCount,
      this.oldCount});

  Songlist.fromJson(Map<String, dynamic> json) {
    frankingValue = json['Franking_value'];
    curCount = json['cur_count'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    inCount = json['in_count'];
    oldCount = json['old_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Franking_value'] = this.frankingValue;
    data['cur_count'] = this.curCount;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['in_count'] = this.inCount;
    data['old_count'] = this.oldCount;
    return data;
  }
}

class Data {
  String? albumdesc;
  int? albumid;
  String? albummid;
  String? albumname;
  int? alertid;
  int? belongCD;
  int? cdIdx;
  int? interval;
  int? isonly;
  String? label;
  int? msgid;
  Pay? pay;
  Preview? preview;
  int? rate;
  List<Singer>? singer;
  int? size128;
  int? size320;
  int? size51;
  int? sizeape;
  int? sizeflac;
  int? sizeogg;
  int? songid;
  String? songmid;
  String? songname;
  String? songorig;
  int? songtype;
  String? strMediaMid;
  int? stream;
  int? switch1;
  int? type;
  String? vid;

  Data(
      {this.albumdesc,
      this.albumid,
      this.albummid,
      this.albumname,
      this.alertid,
      this.belongCD,
      this.cdIdx,
      this.interval,
      this.isonly,
      this.label,
      this.msgid,
      this.pay,
      this.preview,
      this.rate,
      this.singer,
      this.size128,
      this.size320,
      this.size51,
      this.sizeape,
      this.sizeflac,
      this.sizeogg,
      this.songid,
      this.songmid,
      this.songname,
      this.songorig,
      this.songtype,
      this.strMediaMid,
      this.stream,
      this.switch1,
      this.type,
      this.vid});

  Data.fromJson(Map<String, dynamic> json) {
    albumdesc = json['albumdesc'];
    albumid = json['albumid'];
    albummid = json['albummid'];
    albumname = json['albumname'];
    alertid = json['alertid'];
    belongCD = json['belongCD'];
    cdIdx = json['cdIdx'];
    interval = json['interval'];
    isonly = json['isonly'];
    label = json['label'];
    msgid = json['msgid'];
    pay = json['pay'] != null ? new Pay.fromJson(json['pay']) : null;
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
    rate = json['rate'];
    if (json['singer'] != null) {
      singer = [];
      json['singer'].forEach((v) {
        singer?.add(new Singer.fromJson(v));
      });
    }
    size128 = json['size128'];
    size320 = json['size320'];
    size51 = json['size5_1'];
    sizeape = json['sizeape'];
    sizeflac = json['sizeflac'];
    sizeogg = json['sizeogg'];
    songid = json['songid'];
    songmid = json['songmid'];
    songname = json['songname'];
    songorig = json['songorig'];
    songtype = json['songtype'];
    strMediaMid = json['strMediaMid'];
    stream = json['stream'];
    switch1 = json['switch'];
    type = json['type'];
    vid = json['vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumdesc'] = this.albumdesc;
    data['albumid'] = this.albumid;
    data['albummid'] = this.albummid;
    data['albumname'] = this.albumname;
    data['alertid'] = this.alertid;
    data['belongCD'] = this.belongCD;
    data['cdIdx'] = this.cdIdx;
    data['interval'] = this.interval;
    data['isonly'] = this.isonly;
    data['label'] = this.label;
    data['msgid'] = this.msgid;
    if (this.pay != null) {
      data['pay'] = this.pay?.toJson();
    }
    if (this.preview != null) {
      data['preview'] = this.preview?.toJson();
    }
    data['rate'] = this.rate;
    if (this.singer != null) {
      data['singer'] = this.singer?.map((v) => v.toJson()).toList();
    }
    data['size128'] = this.size128;
    data['size320'] = this.size320;
    data['size5_1'] = this.size51;
    data['sizeape'] = this.sizeape;
    data['sizeflac'] = this.sizeflac;
    data['sizeogg'] = this.sizeogg;
    data['songid'] = this.songid;
    data['songmid'] = this.songmid;
    data['songname'] = this.songname;
    data['songorig'] = this.songorig;
    data['songtype'] = this.songtype;
    data['strMediaMid'] = this.strMediaMid;
    data['stream'] = this.stream;
    data['switch'] = this.switch1;
    data['type'] = this.type;
    data['vid'] = this.vid;
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
  int? timefree;

  Pay(
      {this.payalbum,
      this.payalbumprice,
      this.paydownload,
      this.payinfo,
      this.payplay,
      this.paytrackmouth,
      this.paytrackprice,
      this.timefree});

  Pay.fromJson(Map<String, dynamic> json) {
    payalbum = json['payalbum'];
    payalbumprice = json['payalbumprice'];
    paydownload = json['paydownload'];
    payinfo = json['payinfo'];
    payplay = json['payplay'];
    paytrackmouth = json['paytrackmouth'];
    paytrackprice = json['paytrackprice'];
    timefree = json['timefree'];
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
    data['timefree'] = this.timefree;
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

  Singer({this.id, this.mid, this.name});

  Singer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    return data;
  }
}

class Topinfo {
  String? listName;
  String? macDetailPicUrl;
  String? macListPicUrl;
  String? updateType;
  String? albuminfo;
  String? headPicV12;
  String? info;
  int? listennum;
  String? pic;
  String? picDetail;
  String? picAlbum;
  String? picH5;
  String? picV11;
  String? picV12;
  String? topID;
  String? type;

  Topinfo(
      {this.listName,
      this.macDetailPicUrl,
      this.macListPicUrl,
      this.updateType,
      this.albuminfo,
      this.headPicV12,
      this.info,
      this.listennum,
      this.pic,
      this.picDetail,
      this.picAlbum,
      this.picH5,
      this.picV11,
      this.picV12,
      this.topID,
      this.type});

  Topinfo.fromJson(Map<String, dynamic> json) {
    listName = json['ListName'];
    macDetailPicUrl = json['MacDetailPicUrl'];
    macListPicUrl = json['MacListPicUrl'];
    updateType = json['UpdateType'];
    albuminfo = json['albuminfo'];
    headPicV12 = json['headPic_v12'];
    info = json['info'];
    listennum = json['listennum'];
    pic = json['pic'];
    picDetail = json['picDetail'];
    picAlbum = json['pic_album'];
    picH5 = json['pic_h5'];
    picV11 = json['pic_v11'];
    picV12 = json['pic_v12'];
    topID = json['topID'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ListName'] = this.listName;
    data['MacDetailPicUrl'] = this.macDetailPicUrl;
    data['MacListPicUrl'] = this.macListPicUrl;
    data['UpdateType'] = this.updateType;
    data['albuminfo'] = this.albuminfo;
    data['headPic_v12'] = this.headPicV12;
    data['info'] = this.info;
    data['listennum'] = this.listennum;
    data['pic'] = this.pic;
    data['picDetail'] = this.picDetail;
    data['pic_album'] = this.picAlbum;
    data['pic_h5'] = this.picH5;
    data['pic_v11'] = this.picV11;
    data['pic_v12'] = this.picV12;
    data['topID'] = this.topID;
    data['type'] = this.type;
    return data;
  }
}
