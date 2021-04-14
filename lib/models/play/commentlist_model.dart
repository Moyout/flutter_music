import 'package:flutter_music/util/tools.dart';

class CommentListRequest {
  static Future<CommentListModel?> getCommentList(String topid, {int page = 0}) async {
    String url =
        "https://c.y.qq.com/base/fcgi-bin/fcg_global_comment_h5.fcg?format=json&biztype=1&topid=$topid&cmd=8&pagenum=$page&pagesize=25";
    var date = await BaseRequest().toGet("$url");
    CommentListModel clModel = CommentListModel.fromJson(date);
    return clModel;
  }
}

class CommentListModel {
  int? allowComment;
  int? allowSong;
  int? auth;
  int? blackuin;
  int? code;
  Comment? comment;
  String? commentTip;
  Comment? hotComment;
  int? lastscore;
  int? morecomment;
  MsgComment? msgComment;
  int? noCopyright;
  int? showYuerenTip;
  int? subcode;
  int? superadmin;
  String? taogeTopic;
  String? topicName;
  String? topid;

  CommentListModel(
      {this.allowComment,
      this.allowSong,
      this.auth,
      this.blackuin,
      this.code,
      this.comment,
      this.commentTip,
      this.hotComment,
      this.lastscore,
      this.morecomment,
      this.msgComment,
      this.noCopyright,
      this.showYuerenTip,
      this.subcode,
      this.superadmin,
      this.taogeTopic,
      this.topicName,
      this.topid});

  CommentListModel.fromJson(Map<String, dynamic> json) {
    allowComment = json['allow_comment'];
    allowSong = json['allow_song'];
    auth = json['auth'];
    blackuin = json['blackuin'];
    code = json['code'];
    comment = json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
    commentTip = json['comment_tip'];
    hotComment = json['hot_comment'] != null ? new Comment.fromJson(json['hot_comment']) : null;
    lastscore = json['lastscore'];
    morecomment = json['morecomment'];
    msgComment = json['msg_comment'] != null ? new MsgComment.fromJson(json['msg_comment']) : null;
    noCopyright = json['no_copyright'];
    showYuerenTip = json['showYuerenTip'];
    subcode = json['subcode'];
    superadmin = json['superadmin'];
    taogeTopic = json['taoge_topic'];
    topicName = json['topic_name'];
    topid = json['topid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_comment'] = this.allowComment;
    data['allow_song'] = this.allowSong;
    data['auth'] = this.auth;
    data['blackuin'] = this.blackuin;
    data['code'] = this.code;
    if (this.comment != null) {
      data['comment'] = this.comment?.toJson();
    }
    data['comment_tip'] = this.commentTip;
    if (this.hotComment != null) {
      data['hot_comment'] = this.hotComment?.toJson();
    }
    data['lastscore'] = this.lastscore;
    data['morecomment'] = this.morecomment;
    if (this.msgComment != null) {
      data['msg_comment'] = this.msgComment?.toJson();
    }
    data['no_copyright'] = this.noCopyright;
    data['showYuerenTip'] = this.showYuerenTip;
    data['subcode'] = this.subcode;
    data['superadmin'] = this.superadmin;
    data['taoge_topic'] = this.taogeTopic;
    data['topic_name'] = this.topicName;
    data['topid'] = this.topid;
    return data;
  }
}

class Comment {
  List<Commentlist>? commentlist;
  int? commenttotal;

  Comment({this.commentlist, this.commenttotal});

  Comment.fromJson(Map<String, dynamic> json) {
    if (json['commentlist'] != null) {
      commentlist = [];
      json['commentlist'].forEach((v) {
        commentlist?.add(new Commentlist.fromJson(v));
      });
    }
    commenttotal = json['commenttotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentlist != null) {
      data['commentlist'] = this.commentlist?.map((v) => v.toJson()).toList();
    }
    data['commenttotal'] = this.commenttotal;
    return data;
  }
}

class Commentlist {
  String? avatarurl;
  String? commentid;
  int? commitState;
  int? enableDelete;
  String? encryptRootcommentuin;
  String? encryptUin;
  String? identityPic;
  int? identityType;
  int? isHot;
  int? isHotCmt;
  int? isMedal;
  int? isStick;
  int? ispraise;
  List<Middlecommentcontent>? middlecommentcontent;
  String? nick;
  int? permission;
  int? praisenum;
  int? rootEnableDelete;
  String? rootIdentityPic;
  int? rootIdentityType;
  int? rootIsStick;
  String? rootcommentcontent;
  String? rootcommentid;
  String? rootcommentnick;
  String? rootcommentuin;
  int? score;
  String? taogeTopic;
  String? taogeUrl;
  int? time;
  String? uin;
  String? userType;
  String? vipicon;

  Commentlist(
      {this.avatarurl,
      this.commentid,
      this.commitState,
      this.enableDelete,
      this.encryptRootcommentuin,
      this.encryptUin,
      this.identityPic,
      this.identityType,
      this.isHot,
      this.isHotCmt,
      this.isMedal,
      this.isStick,
      this.ispraise,
      this.middlecommentcontent,
      this.nick,
      this.permission,
      this.praisenum,
      this.rootEnableDelete,
      this.rootIdentityPic,
      this.rootIdentityType,
      this.rootIsStick,
      this.rootcommentcontent,
      this.rootcommentid,
      this.rootcommentnick,
      this.rootcommentuin,
      this.score,
      this.taogeTopic,
      this.taogeUrl,
      this.time,
      this.uin,
      this.userType,
      this.vipicon});

  Commentlist.fromJson(Map<String, dynamic> json) {
    avatarurl = json['avatarurl'];
    commentid = json['commentid'];
    commitState = json['commit_state'];
    enableDelete = json['enable_delete'];
    encryptRootcommentuin = json['encrypt_rootcommentuin'];
    encryptUin = json['encrypt_uin'];
    identityPic = json['identity_pic'];
    identityType = json['identity_type'];
    isHot = json['is_hot'];
    isHotCmt = json['is_hot_cmt'];
    isMedal = json['is_medal'];
    isStick = json['is_stick'];
    ispraise = json['ispraise'];
    if (json['middlecommentcontent'] != null) {
      middlecommentcontent = [];
      json['middlecommentcontent'].forEach((v) {
        middlecommentcontent?.add(new Middlecommentcontent.fromJson(v));
      });
    }
    nick = json['nick'];
    permission = json['permission'];
    praisenum = json['praisenum'];
    rootEnableDelete = json['root_enable_delete'];
    rootIdentityPic = json['root_identity_pic'];
    rootIdentityType = json['root_identity_type'];
    rootIsStick = json['root_is_stick'];
    rootcommentcontent = json['rootcommentcontent'];
    rootcommentid = json['rootcommentid'];
    rootcommentnick = json['rootcommentnick'];
    rootcommentuin = json['rootcommentuin'];
    score = json['score'];
    taogeTopic = json['taoge_topic'];
    taogeUrl = json['taoge_url'];
    time = json['time'];
    uin = json['uin'];
    userType = json['user_type'];
    vipicon = json['vipicon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarurl'] = this.avatarurl;
    data['commentid'] = this.commentid;
    data['commit_state'] = this.commitState;
    data['enable_delete'] = this.enableDelete;
    data['encrypt_rootcommentuin'] = this.encryptRootcommentuin;
    data['encrypt_uin'] = this.encryptUin;
    data['identity_pic'] = this.identityPic;
    data['identity_type'] = this.identityType;
    data['is_hot'] = this.isHot;
    data['is_hot_cmt'] = this.isHotCmt;
    data['is_medal'] = this.isMedal;
    data['is_stick'] = this.isStick;
    data['ispraise'] = this.ispraise;
    if (this.middlecommentcontent != null) {
      data['middlecommentcontent'] = this.middlecommentcontent?.map((v) => v.toJson()).toList();
    }
    data['nick'] = this.nick;
    data['permission'] = this.permission;
    data['praisenum'] = this.praisenum;
    data['root_enable_delete'] = this.rootEnableDelete;
    data['root_identity_pic'] = this.rootIdentityPic;
    data['root_identity_type'] = this.rootIdentityType;
    data['root_is_stick'] = this.rootIsStick;
    data['rootcommentcontent'] = this.rootcommentcontent;
    data['rootcommentid'] = this.rootcommentid;
    data['rootcommentnick'] = this.rootcommentnick;
    data['rootcommentuin'] = this.rootcommentuin;
    data['score'] = this.score;
    data['taoge_topic'] = this.taogeTopic;
    data['taoge_url'] = this.taogeUrl;
    data['time'] = this.time;
    data['uin'] = this.uin;
    data['user_type'] = this.userType;
    data['vipicon'] = this.vipicon;
    return data;
  }
}

class Middlecommentcontent {
  String? encryptReplyeduin;
  String? encryptReplyuin;
  String? replyIdentityPic;
  int? replyIdentityType;
  String? replyedIdentityPic;
  int? replyedIdentityType;
  String? replyednick;
  String? replyeduin;
  String? replynick;
  String? replyuin;
  String? subcommentcontent;
  String? subcommentid;

  Middlecommentcontent(
      {this.encryptReplyeduin,
      this.encryptReplyuin,
      this.replyIdentityPic,
      this.replyIdentityType,
      this.replyedIdentityPic,
      this.replyedIdentityType,
      this.replyednick,
      this.replyeduin,
      this.replynick,
      this.replyuin,
      this.subcommentcontent,
      this.subcommentid});

  Middlecommentcontent.fromJson(Map<String, dynamic> json) {
    encryptReplyeduin = json['encrypt_replyeduin'];
    encryptReplyuin = json['encrypt_replyuin'];
    replyIdentityPic = json['reply_identity_pic'];
    replyIdentityType = json['reply_identity_type'];
    replyedIdentityPic = json['replyed_identity_pic'];
    replyedIdentityType = json['replyed_identity_type'];
    replyednick = json['replyednick'];
    replyeduin = json['replyeduin'];
    replynick = json['replynick'];
    replyuin = json['replyuin'];
    subcommentcontent = json['subcommentcontent'];
    subcommentid = json['subcommentid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encrypt_replyeduin'] = this.encryptReplyeduin;
    data['encrypt_replyuin'] = this.encryptReplyuin;
    data['reply_identity_pic'] = this.replyIdentityPic;
    data['reply_identity_type'] = this.replyIdentityType;
    data['replyed_identity_pic'] = this.replyedIdentityPic;
    data['replyed_identity_type'] = this.replyedIdentityType;
    data['replyednick'] = this.replyednick;
    data['replyeduin'] = this.replyeduin;
    data['replynick'] = this.replynick;
    data['replyuin'] = this.replyuin;
    data['subcommentcontent'] = this.subcommentcontent;
    data['subcommentid'] = this.subcommentid;
    return data;
  }
}

class MsgComment {
  Null? commentlist;
  int? commenttotal;

  MsgComment({this.commentlist, this.commenttotal});

  MsgComment.fromJson(Map<String, dynamic> json) {
    commentlist = json['commentlist'];
    commenttotal = json['commenttotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentlist'] = this.commentlist;
    data['commenttotal'] = this.commenttotal;
    return data;
  }
}
