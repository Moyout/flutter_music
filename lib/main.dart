import 'package:flutter_music/provider/provider_list.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/startup_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = null; //禁止provider红屏
  WidgetsFlutterBinding.ensureInitialized(); //禁止provider红屏
  ScreenUtil.initialize(); //初始化屏幕适配
  AppConfig.initSp(); //初始化SP
  AppConfig.errorWidget(); //错误widget

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Simple Music',
        home: StartUpPage(),
        initialRoute: '/',
        routes: {},
        themeMode: ThemeMode.dark,
        theme: ThemeUtil.lightTheme(),
        darkTheme: ThemeUtil.darkTheme(),
      ),
    );
  }
}
