import 'package:flutter_music/provider/provider_list.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/views/startup_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = null; //Provider 状态管理，同步数据
  WidgetsFlutterBinding
      .ensureInitialized(); //WidgetsFlutterBinding 承担各类的初始化以及功能配置
  ScreenUtil.initialize(); //初始化屏幕适配
  AppConfig.initSp(); //初始化SP
  AppConfig.errorWidget(); //错误widget

  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.initialize(); //初始化屏幕适配
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Simple Music',
      home: StartUpPage(),
      navigatorKey: AppUtils.navigatorKey,

      // initialRoute: '/',
      routes: {},
      themeMode: context.watch<SetViewModel>().isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeUtil.lightTheme(),
      darkTheme: ThemeUtil.darkTheme(),
    );
  }
}
