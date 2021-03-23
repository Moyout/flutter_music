import 'dart:convert';

class Base64 {
  /// Base64加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解密
  static String decodeBase64(String data) {
    var digest = utf8.decode(base64Decode(data));

    return digest;

    // return String.fromCharCodes(base64Decode(data));
  }
}
