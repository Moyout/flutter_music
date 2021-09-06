///
///author: DJT
///created on: 2021/9/6 10:33
///
import 'package:flutter_music/util/tools.dart';

class BannerModelRequest {
  static Future<BannerModel?> getBannerList( ) async {
    String url = 'https://www.wanandroid.com/banner/json';
    var response = await BaseRequest().toGet(url);
    if (response != null) {
      BannerModel bannerModel = BannerModel.fromJson(response);
      return bannerModel;
    }
    return null;
  }
}

class BannerModel {
  List<Data>? data;
  int? errorCode;
  String? errorMsg;

  BannerModel({this.data, this.errorCode, this.errorMsg});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class Data {
  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  Data({this.desc, this.id, this.imagePath, this.isVisible, this.order, this.title, this.type, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['isVisible'] = this.isVisible;
    data['order'] = this.order;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
