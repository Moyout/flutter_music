import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class MusicKeyRequest {
  static Future<MusicKeyModel?> getMusicVKey(String songmid) async {
    String dataURL =
        'http://u.y.qq.com/cgi-bin/musicu.fcg?data={"req_0":{"module":"vkey.GetVkeyServer","method":"CgiGetVkey","param":{"guid":"5339940689","songmid":["$songmid"],"songtype":[0],"uin":"","platform":"20"}}}';
    var data = await BaseRequest().toGet(
      dataURL,
      options: Options(responseType: ResponseType.plain),
    );
    MusicKeyModel musicKeyModel = MusicKeyModel.fromJson(data);
    return musicKeyModel;
  }
}

class MusicKeyModel {
  int? code;
  int? ts;
  int? startTs;
  Req0? req0;

  MusicKeyModel({this.code, this.ts, this.startTs, this.req0});

  MusicKeyModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    ts = json['ts'];
    startTs = json['start_ts'];
    req0 = json['req_0'] != null ? new Req0.fromJson(json['req_0']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['ts'] = this.ts;
    data['start_ts'] = this.startTs;
    if (this.req0 != null) {
      data['req_0'] = this.req0?.toJson();
    }
    return data;
  }
}

class Req0 {
  int? code;
  Data? data;

  Req0({this.code, this.data});

  Req0.fromJson(Map<String, dynamic> json) {
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
  int? expiration;
  String? loginKey;
  List<Midurlinfo>? midurlinfo;
  String? msg;
  int? retcode;
  String? servercheck;
  List<String>? sip;
  String? testfile2g;
  String? testfilewifi;
  List<String>? thirdip;
  String? uin;
  int? verifyType;

  Data(
      {this.expiration,
      this.loginKey,
      this.midurlinfo,
      this.msg,
      this.retcode,
      this.servercheck,
      this.sip,
      this.testfile2g,
      this.testfilewifi,
      this.thirdip,
      this.uin,
      this.verifyType});

  Data.fromJson(Map<String, dynamic> json) {
    expiration = json['expiration'];
    loginKey = json['login_key'];
    if (json['midurlinfo'] != null) {
      midurlinfo = [];
      json['midurlinfo'].forEach((v) {
        midurlinfo?.add(new Midurlinfo.fromJson(v));
      });
    }
    msg = json['msg'];
    retcode = json['retcode'];
    servercheck = json['servercheck'];
    sip = json['sip'].cast<String>();
    testfile2g = json['testfile2g'];
    testfilewifi = json['testfilewifi'];
    thirdip = json['thirdip'].cast<String>();
    uin = json['uin'];
    verifyType = json['verify_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiration'] = this.expiration;
    data['login_key'] = this.loginKey;
    if (this.midurlinfo != null) {
      data['midurlinfo'] = this.midurlinfo?.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['retcode'] = this.retcode;
    data['servercheck'] = this.servercheck;
    data['sip'] = this.sip;
    data['testfile2g'] = this.testfile2g;
    data['testfilewifi'] = this.testfilewifi;
    data['thirdip'] = this.thirdip;
    data['uin'] = this.uin;
    data['verify_type'] = this.verifyType;
    return data;
  }
}

class Midurlinfo {
  int? authSwitch;
  int? commonDownfromtag;
  String? ekey;
  String? errtype;
  String? filename;
  String? flowfromtag;
  String? flowurl;
  int? hisbuy;
  int? hisdown;
  int? isbuy;
  int? isonly;
  int? onecan;
  String? opi128kurl;
  String? opi192koggurl;
  String? opi192kurl;
  String? opi30surl;
  String? opi48kurl;
  String? opi96kurl;
  String? opiflackurl;
  int? p2pfromtag;
  int? pdl;
  int? pneed;
  int? pneedbuy;
  int? premain;
  String? purl;
  int? qmdlfromtag;
  int? result;
  String? songmid;
  String? tips;
  int? uiAlert;
  int? vipDownfromtag;
  String? vkey;
  String? wififromtag;
  String? wifiurl;

  Midurlinfo(
      {this.authSwitch,
      this.commonDownfromtag,
      this.ekey,
      this.errtype,
      this.filename,
      this.flowfromtag,
      this.flowurl,
      this.hisbuy,
      this.hisdown,
      this.isbuy,
      this.isonly,
      this.onecan,
      this.opi128kurl,
      this.opi192koggurl,
      this.opi192kurl,
      this.opi30surl,
      this.opi48kurl,
      this.opi96kurl,
      this.opiflackurl,
      this.p2pfromtag,
      this.pdl,
      this.pneed,
      this.pneedbuy,
      this.premain,
      this.purl,
      this.qmdlfromtag,
      this.result,
      this.songmid,
      this.tips,
      this.uiAlert,
      this.vipDownfromtag,
      this.vkey,
      this.wififromtag,
      this.wifiurl});

  Midurlinfo.fromJson(Map<String, dynamic> json) {
    authSwitch = json['auth_switch'];
    commonDownfromtag = json['common_downfromtag'];
    ekey = json['ekey'];
    errtype = json['errtype'];
    filename = json['filename'];
    flowfromtag = json['flowfromtag'];
    flowurl = json['flowurl'];
    hisbuy = json['hisbuy'];
    hisdown = json['hisdown'];
    isbuy = json['isbuy'];
    isonly = json['isonly'];
    onecan = json['onecan'];
    opi128kurl = json['opi128kurl'];
    opi192koggurl = json['opi192koggurl'];
    opi192kurl = json['opi192kurl'];
    opi30surl = json['opi30surl'];
    opi48kurl = json['opi48kurl'];
    opi96kurl = json['opi96kurl'];
    opiflackurl = json['opiflackurl'];
    p2pfromtag = json['p2pfromtag'];
    pdl = json['pdl'];
    pneed = json['pneed'];
    pneedbuy = json['pneedbuy'];
    premain = json['premain'];
    purl = json['purl'];
    qmdlfromtag = json['qmdlfromtag'];
    result = json['result'];
    songmid = json['songmid'];
    tips = json['tips'];
    uiAlert = json['uiAlert'];
    vipDownfromtag = json['vip_downfromtag'];
    vkey = json['vkey'];
    wififromtag = json['wififromtag'];
    wifiurl = json['wifiurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_switch'] = this.authSwitch;
    data['common_downfromtag'] = this.commonDownfromtag;
    data['ekey'] = this.ekey;
    data['errtype'] = this.errtype;
    data['filename'] = this.filename;
    data['flowfromtag'] = this.flowfromtag;
    data['flowurl'] = this.flowurl;
    data['hisbuy'] = this.hisbuy;
    data['hisdown'] = this.hisdown;
    data['isbuy'] = this.isbuy;
    data['isonly'] = this.isonly;
    data['onecan'] = this.onecan;
    data['opi128kurl'] = this.opi128kurl;
    data['opi192koggurl'] = this.opi192koggurl;
    data['opi192kurl'] = this.opi192kurl;
    data['opi30surl'] = this.opi30surl;
    data['opi48kurl'] = this.opi48kurl;
    data['opi96kurl'] = this.opi96kurl;
    data['opiflackurl'] = this.opiflackurl;
    data['p2pfromtag'] = this.p2pfromtag;
    data['pdl'] = this.pdl;
    data['pneed'] = this.pneed;
    data['pneedbuy'] = this.pneedbuy;
    data['premain'] = this.premain;
    data['purl'] = this.purl;
    data['qmdlfromtag'] = this.qmdlfromtag;
    data['result'] = this.result;
    data['songmid'] = this.songmid;
    data['tips'] = this.tips;
    data['uiAlert'] = this.uiAlert;
    data['vip_downfromtag'] = this.vipDownfromtag;
    data['vkey'] = this.vkey;
    data['wififromtag'] = this.wififromtag;
    data['wifiurl'] = this.wifiurl;
    return data;
  }
}
