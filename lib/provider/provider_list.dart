import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/login/login_viewmodel.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/view_models/startup_viewmodel.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => SetViewModel()),
  ChangeNotifierProvider(create: (_) => StartUpViewModel()),
  ChangeNotifierProvider(create: (_) => NavViewModel()),
  ChangeNotifierProvider(create: (_) => PlayBarViewModel()),
  ChangeNotifierProvider(create: (_) => SearchViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
];

//这里使用ProxyProvider来定义需要依赖其他Provider的服务
List<SingleChildWidget> dependentServices = [];
