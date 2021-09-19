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
    req0 = json['req_0'] != null ? Req0.fromJson(json['req_0']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['ts'] = ts;
    data['start_ts'] = startTs;
    if (req0 != null) {
      data['req_0'] = req0?.toJson();
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
        midurlinfo?.add(Midurlinfo.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiration'] = expiration;
    data['login_key'] = loginKey;
    if (midurlinfo != null) {
      data['midurlinfo'] = midurlinfo?.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['retcode'] = retcode;
    data['servercheck'] = servercheck;
    data['sip'] = sip;
    data['testfile2g'] = testfile2g;
    data['testfilewifi'] = testfilewifi;
    data['thirdip'] = thirdip;
    data['uin'] = uin;
    data['verify_type'] = verifyType;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth_switch'] = authSwitch;
    data['common_downfromtag'] = commonDownfromtag;
    data['ekey'] = ekey;
    data['errtype'] = errtype;
    data['filename'] = filename;
    data['flowfromtag'] = flowfromtag;
    data['flowurl'] = flowurl;
    data['hisbuy'] = hisbuy;
    data['hisdown'] = hisdown;
    data['isbuy'] = isbuy;
    data['isonly'] = isonly;
    data['onecan'] = onecan;
    data['opi128kurl'] = opi128kurl;
    data['opi192koggurl'] = opi192koggurl;
    data['opi192kurl'] = opi192kurl;
    data['opi30surl'] = opi30surl;
    data['opi48kurl'] = opi48kurl;
    data['opi96kurl'] = opi96kurl;
    data['opiflackurl'] = opiflackurl;
    data['p2pfromtag'] = p2pfromtag;
    data['pdl'] = pdl;
    data['pneed'] = pneed;
    data['pneedbuy'] = pneedbuy;
    data['premain'] = premain;
    data['purl'] = purl;
    data['qmdlfromtag'] = qmdlfromtag;
    data['result'] = result;
    data['songmid'] = songmid;
    data['tips'] = tips;
    data['uiAlert'] = uiAlert;
    data['vip_downfromtag'] = vipDownfromtag;
    data['vkey'] = vkey;
    data['wififromtag'] = wififromtag;
    data['wifiurl'] = wifiurl;
    return data;
  }
}
