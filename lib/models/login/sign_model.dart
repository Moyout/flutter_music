import 'package:flutter_music/util/tools.dart';

class SignRequest {
  static Future<SignModel> getSign(
    String userName,
    String passWord,
    String email,
    String code,
  ) async {
    String url =
        'http://106.52.246.134:5000/sign?userName=$userName&passWord=$passWord&mailBox=$email&verificationCode=$code';
    var response = await BaseRequest().toPost(url);
    SignModel sModel = SignModel.fromJson(response);
    return sModel;
  }
}

class SignModel {
  String? code;
  Data? data;
  String? message;

  SignModel({this.code, this.data, this.message});

  SignModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? passWord;
  String? userName;

  Data({this.passWord, this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    passWord = json['passWord'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passWord'] = this.passWord;
    data['userName'] = this.userName;
    return data;
  }
}
