/// 邮箱正则
const String regexEmail =
    "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

/// 检查是否是邮箱格式
bool isEmail(String input) {
  // if (input == null || input.isEmpty) return false;
  return RegExp(regexEmail).hasMatch(input);
}

const String dayIdle = "day_idle";
const String nightIdle = "night_idle";
const String switchNight = "switch_night";
const String switchDay = "switch_day";
