import 'package:flutter_music/util/tools.dart';

class SendCodeRequest {
  static Future<SendCodeModel> sendCode(String email) async {
    String url = 'http://api.moyou.website/verificationCode?mailBox=$email';
    var response = await BaseRequest().toGet(url);
    SendCodeModel scModel = SendCodeModel.fromJson(response);
    return scModel;
  }
}

class SendCodeModel {
  String? code;
  String? message;

  SendCodeModel({this.code, this.message});

  SendCodeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
