import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';
import 'package:flutter_music/view_models/startup_viewmodel.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => StartUpViewModel()),
  ChangeNotifierProvider(create: (_) => NavViewModel()),
  ChangeNotifierProvider(create: (_) => PlayBarViewModel()),
];

//这里使用ProxyProvider来定义需要依赖其他Provider的服务
List<SingleChildWidget> dependentServices = [];
