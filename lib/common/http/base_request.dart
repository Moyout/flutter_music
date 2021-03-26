import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_music/common/toast/toast.dart';

class BaseRequest {
  static BaseRequest _instance = BaseRequest._internal();
  Dio? dio;

  // CancelToken cancelToken = CancelToken();
  Response? response;

  factory BaseRequest() => _instance;

  BaseRequest._internal() {
    dio = Dio(BaseOptions(connectTimeout: 10000, receiveTimeout: 5000));
  }

  ///拦截器
  void interceptor() {
    if (dio?.interceptors.length == 0)
      dio?.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print("\n================== 请求数据 ==========================");
          print("url = ${options.uri.toString()}");
          print("headers = ${options.headers}");
          print("params = ${options.data}");
          Toast.showLoadingToast(seconds: 10, clickClose: false);
          // cancelToken.cancel();
        },
        onResponse: (Response response) {
          print("\n================== 响应数据 ==========================");
          print("code = ${response.statusCode}");
          print("data = ${response.data}");
          print("\n");
          Toast.closeLoading();
        },
        onError: (DioError e) {
          print("\n================== 错误响应数据 ======================");
          print("type = ${e.type}");
          print("message = ${e.message}");
          print("\n");
          // Toast.showBotToast(e.message);

          /*error统一处理*/
          if (e.type == DioErrorType.CONNECT_TIMEOUT)
            Toast.showBotToast("连接超时");
          else if (e.type == DioErrorType.SEND_TIMEOUT)
            Toast.showBotToast("请求超时");
          else if (e.type == DioErrorType.RECEIVE_TIMEOUT)
            Toast.showBotToast("响应超时");
          else if (e.type == DioErrorType.RESPONSE)
            Toast.showBotToast("出现异常");
          else if (e.type == DioErrorType.CANCEL)
            Toast.showBotToast("请求取消");
          else
            Toast.showBotToast("请求错误");
        },
      ));
  }

  ///get请求
  Future toGet(
    url, {
    Map<String, dynamic>? parameters,
    Options? options,
  }) async {
    interceptor();
    var result;
    response = await dio?.get(
      url,
      queryParameters: parameters,
      options: options,
      // cancelToken: cancelToken,
    );
    try {
      result = await jsonDecode(response?.data);
    } catch (e) {
      print("=========jsonDecode 错误" + e.toString());
      result = response?.data;
    }

    return result;
  }

  ///post请求
  Future<dynamic> toPost(url,
      {data, Map<String, dynamic>? parameters, Options? options}) async {
    interceptor();
    response = await dio!
        .post(
      url,
      queryParameters: parameters,
      options: options,
      data: data,
    )
        .catchError((e) {
      print("===============================>$e");
    });
    // print("################${response.data}");

    return response?.data;
  }
}
