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
      data: FormData.fromMap(map),
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

  LoginModel({this.code, this.message, this.token, this.userName});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'].toString();
    token = json['token_'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message.toString();
    data['token_'] = token;
    data['userName'] = userName;
    return data;
  }
}
