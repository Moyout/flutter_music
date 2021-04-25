import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_music/common/toast/toast.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';

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
    if (dio?.interceptors.length == 0) {
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
        onError: (DioError e) async {
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
          else if (e.type == DioErrorType.DEFAULT)
            Toast.showBotToast("请求错误");
          else
            Toast.showBotToast("请求错误");
          Future.delayed(Duration(milliseconds: 1000), () {
            Toast.closeLoading();
          });
        },
      ));
    }
  }

  ///get请求
  Future toGet(
    url, {
    Map<String, dynamic>? parameters,
    Options? options,
  }) async {
    var result;
    if (AppUtils.getContext().read<NavViewModel>().netMode ==
        ConnectivityResult.none) {
      Toast.showBotToast("请检查网络");
    } else {
      interceptor();
      response = await dio?.get(
        url, queryParameters: parameters, options: options,
        // cancelToken: cancelToken,
      );
      try {
        result = await jsonDecode(response?.data);
      } catch (e) {
        print("=========jsonDecode 错误" + e.toString());
        result = response?.data;
      }
    }

    return result;
  }

  ///post请求
  Future<dynamic> toPost(
    url, {
    data,
    Map<String, dynamic>? parameters,
    Options? options,
  }) async {
    if (AppUtils.getContext().read<NavViewModel>().netMode ==
        ConnectivityResult.none) {
      Toast.showBotToast("请检查网络");
    } else {
      interceptor();
      response = await dio!
          .post(
        url,
        queryParameters: parameters,
        options: options,
        data: data,
      )
          .catchError((e) {
        print("=======post错误========================>$e");
      });
      // print("################${response.data}");
    }
    return response?.data;
  }

  /*
   * 下载文件
   */
  Future<dynamic> downloadFile(urlPath, savePath) async {
    try {
      String progress = "";
      response = await dio?.download(
        urlPath,
        savePath,
        onReceiveProgress: (int count, int total) {
          //进度
          print("${(count / total).toStringAsFixed(2)}");
          progress = (count / total).toStringAsFixed(2);
        },
        // cancelToken: CancelToken(),//取消操作
      );
      return progress;
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      return response;
    }
  }
}
