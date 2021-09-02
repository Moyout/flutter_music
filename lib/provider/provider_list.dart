import 'package:flutter_music/provider/click_effect_provider.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/login/login_viewmodel.dart';
import 'package:flutter_music/view_models/music_hall/musichall_viewmodel.dart';
import 'package:flutter_music/view_models/mv/mv_viewmodel.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
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
  ChangeNotifierProvider(create: (_) => PlayPageViewModel()),
  ChangeNotifierProvider(create: (_) => MusicHallViewModel()),
  ChangeNotifierProvider(create: (_) => MvViewModel()),
  ChangeNotifierProvider(create: (_) => ClickEffectProvider()),
];

//这里使用ProxyProvider来定义需要依赖其他Provider的服务
List<SingleChildWidget> dependentServices = [];
