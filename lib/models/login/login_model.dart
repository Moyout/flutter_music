import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class LoginRequest {
  static Future<LoginModel> getLogin({
    String? userName,
    String? passWord,
    Map<String, dynamic>? headers,
  }) async {
    Map<String, dynamic> map = {"userName": userName ?? "", "passWord": passWord ?? ""};
    var response = await BaseRequest().toPost(
      "http://106.52.246.134:5000/login",
      // data: FormData.fromMap(map),
      data: map,
      options: Options(headers: headers),
    );
    LoginModel lModel = LoginModel.fromJson(response);
    return lModel;
  }
}

class LoginModel {
  String? code;
  String? message;
  String? token;
  String? userName;
  String? avatar;

  LoginModel({this.code, this.message, this.token, this.userName,this.avatar});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'].toString();
    token = json['token_'];
    userName = json['userName'];
    avatar = json['avatar'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message.toString();
    data['token_'] = token;
    data['userName'] = userName;
    data['avatar'] = avatar;
    return data;
  }
}
