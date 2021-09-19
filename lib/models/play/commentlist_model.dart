import 'package:flutter_music/util/tools.dart';

class CommentListRequest {
  static Future<CommentListModel?> getCommentList(String topid, {int page = 0}) async {
    String url =
        "https://c.y.qq.com/base/fcgi-bin/fcg_global_comment_h5.fcg?format=json&biztype=1&topid=$topid&cmd=8&pagenum=$page&pagesize=25";
    var date = await BaseRequest().toGet(url);
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
    comment = json['comment'] != null ? Comment.fromJson(json['comment']) : null;
    commentTip = json['comment_tip'];
    hotComment = json['hot_comment'] != null ? Comment.fromJson(json['hot_comment']) : null;
    lastscore = json['lastscore'];
    morecomment = json['morecomment'];
    msgComment = json['msg_comment'] != null ? MsgComment.fromJson(json['msg_comment']) : null;
    noCopyright = json['no_copyright'];
    showYuerenTip = json['showYuerenTip'];
    subcode = json['subcode'];
    superadmin = json['superadmin'];
    taogeTopic = json['taoge_topic'];
    topicName = json['topic_name'];
    topid = json['topid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allow_comment'] = allowComment;
    data['allow_song'] = allowSong;
    data['auth'] = auth;
    data['blackuin'] = blackuin;
    data['code'] = code;
    if (comment != null) {
      data['comment'] = comment?.toJson();
    }
    data['comment_tip'] = commentTip;
    if (hotComment != null) {
      data['hot_comment'] = hotComment?.toJson();
    }
    data['lastscore'] = lastscore;
    data['morecomment'] = morecomment;
    if (msgComment != null) {
      data['msg_comment'] = msgComment?.toJson();
    }
    data['no_copyright'] = noCopyright;
    data['showYuerenTip'] = showYuerenTip;
    data['subcode'] = subcode;
    data['superadmin'] = superadmin;
    data['taoge_topic'] = taogeTopic;
    data['topic_name'] = topicName;
    data['topid'] = topid;
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
        commentlist?.add(Commentlist.fromJson(v));
      });
    }
    commenttotal = json['commenttotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commentlist != null) {
      data['commentlist'] = commentlist?.map((v) => v.toJson()).toList();
    }
    data['commenttotal'] = commenttotal;
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
        middlecommentcontent?.add(Middlecommentcontent.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatarurl'] = avatarurl;
    data['commentid'] = commentid;
    data['commit_state'] = commitState;
    data['enable_delete'] = enableDelete;
    data['encrypt_rootcommentuin'] = encryptRootcommentuin;
    data['encrypt_uin'] = encryptUin;
    data['identity_pic'] = identityPic;
    data['identity_type'] = identityType;
    data['is_hot'] = isHot;
    data['is_hot_cmt'] = isHotCmt;
    data['is_medal'] = isMedal;
    data['is_stick'] = isStick;
    data['ispraise'] = ispraise;
    if (middlecommentcontent != null) {
      data['middlecommentcontent'] = middlecommentcontent?.map((v) => v.toJson()).toList();
    }
    data['nick'] = nick;
    data['permission'] = permission;
    data['praisenum'] = praisenum;
    data['root_enable_delete'] = rootEnableDelete;
    data['root_identity_pic'] = rootIdentityPic;
    data['root_identity_type'] = rootIdentityType;
    data['root_is_stick'] = rootIsStick;
    data['rootcommentcontent'] = rootcommentcontent;
    data['rootcommentid'] = rootcommentid;
    data['rootcommentnick'] = rootcommentnick;
    data['rootcommentuin'] = rootcommentuin;
    data['score'] = score;
    data['taoge_topic'] = taogeTopic;
    data['taoge_url'] = taogeUrl;
    data['time'] = time;
    data['uin'] = uin;
    data['user_type'] = userType;
    data['vipicon'] = vipicon;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encrypt_replyeduin'] = encryptReplyeduin;
    data['encrypt_replyuin'] = encryptReplyuin;
    data['reply_identity_pic'] = replyIdentityPic;
    data['reply_identity_type'] = replyIdentityType;
    data['replyed_identity_pic'] = replyedIdentityPic;
    data['replyed_identity_type'] = replyedIdentityType;
    data['replyednick'] = replyednick;
    data['replyeduin'] = replyeduin;
    data['replynick'] = replynick;
    data['replyuin'] = replyuin;
    data['subcommentcontent'] = subcommentcontent;
    data['subcommentid'] = subcommentid;
    return data;
  }
}

class MsgComment {
  void  commentlist;
  int? commenttotal;

  MsgComment({this.commentlist, this.commenttotal});

  MsgComment.fromJson(Map<String, dynamic> json) {
    commentlist = null;
    commenttotal = json['commenttotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentlist'] = null;
    data['commenttotal'] = commenttotal;
    return data;
  }
}
