/// 邮箱正则
final String regexEmail =
    "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

/// 检查是否是邮箱格式
bool isEmail(String input) {
  // if (input == null || input.isEmpty) return false;
  return new RegExp(regexEmail).hasMatch(input);
}
