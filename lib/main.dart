import 'package:flutter_music/provider/provider_list.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/startup_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //禁止provider红屏
  ScreenUtil.initialize(); //初始化屏幕适配
  AppConfig.initSp(); //初始化SP
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Player',
          home: StartUpPage(),
          // navigatorKey: AppUtils.navigatorKey,
          initialRoute: '/',
          routes: {},
          theme: ThemeData(
            textTheme: TextTheme(bodyText2: TextStyle(fontFamily: "FZKT")),
          ),
        ),
      ),
    );
  }
}
