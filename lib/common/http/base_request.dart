import 'dart:convert';

import 'package:dio/dio.dart';

class BaseRequest {
  static BaseRequest _instance = BaseRequest._internal();
  Dio dio;

  Response response;

  factory BaseRequest() => _instance;

  BaseRequest._internal() {
    dio = Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 5000,
    ));
  }

  ///拦截器
  void interceptor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
      },
      onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      },
      onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("\n");
      },
    ));
  }


  ///get请求
  Future<dynamic> toGet(url,
      {Map<String, dynamic> parameters, Options options}) async {
    interceptor();
    var result;
    response =
        await dio.get(url, queryParameters: parameters, options: options);
    try {
      result = await jsonDecode(response.data);
    } catch (e) {
      print("=========jsonDecode 错误" + e.toString());
      result = response.data;
    }

    return result;
  }

  ///post请求
  Future<dynamic> toPost(url,
      {data, Map<String, dynamic> parameters, Options options}) async {
    interceptor();
    response = await dio
        .post(url, queryParameters: parameters, options: options, data: data)
        .catchError((e) {
      print("===============================>$e");
    });
    // print("################${response.data}");

    return response.data;
  }
}
