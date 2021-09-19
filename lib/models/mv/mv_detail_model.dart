import 'package:dio/dio.dart';
import 'package:flutter_music/util/tools.dart';

class MvDetailRequest {
  static Future<String?> getMvDetail(String vids) async {
    String url =
        'https://u.y.qq.com/cgi-bin/musicu.fcg?data={"getMvUrl":{"module":"gosrf.Stream.MvUrlProxy","method":"GetMvUrls","param":{"vids":["$vids"],"request_typet":10001,"addrtype":3,"format":264}},"comm":{"ct":24,"cv":4747474,"format":"json","platform":"yqq"}}';
    var date = await BaseRequest().toGet(url, options: Options(responseType: ResponseType.plain));
    if (date != null) {
      String mvUrl = date["getMvUrl"]["data"][vids]["mp4"][1]["freeflow_url"][0].toString();
      return mvUrl;
    }
    return null;
  }
}
