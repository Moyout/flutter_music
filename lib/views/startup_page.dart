import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/view_models/startup_viewmodel.dart';
import 'package:flutter_music/views/search_page/search_page.dart';
import 'package:quick_actions/quick_actions.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  // String? shortcut;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // const QuickActions quickActions = QuickActions();
    // quickActions.initialize((String shortcutType) {
    //   RouteUtil.push(context, const SearchPage());
    //   shortcut = shortcutType;
    //   debugPrint("shortcut------------------------>$shortcut");
    // });
    //
    // quickActions.setShortcutItems(<ShortcutItem>[
    //   const ShortcutItem(type: 'action1', localizedTitle: '搜索歌曲', icon: 'launcher_icon'),
    // ]);
    // debugPrint("==================>${shortcut ?? "213"}");
    context.read<StartUpViewModel>().initQuickActions();

    if (context.read<StartUpViewModel>().shortcut == null) context.read<StartUpViewModel>().initViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    KeyboardUtil.closeKeyboardUtil();
    StartUpViewModel state = context.read<StartUpViewModel>();
    context.read<SetViewModel>().appInitSetting();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: const NetworkImage("https://bing.ioliu.cn/v1/rand"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.srcOver,
            ),
          ),
        ),
        width: AppUtils.getWidth(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 50.w),
              child: Image.asset(
                "assets/images/logo.png",
                width: AppUtils.getWidth() / 2 - 40.w,
                fit: BoxFit.contain,
              ),
            ),
            Image.asset(
              "assets/images/logo2.png",
              width: AppUtils.getWidth() / 2 - 20.w,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 10.w, right: 30.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child: context.watch<StartUpViewModel>().seconds == 0
                    ? Container()
                    : RawChip(
                        backgroundColor: Colors.transparent,
                        label: Consumer<StartUpViewModel>(
                          builder: (_, StartUpViewModel stModel, __) {
                            return Text(
                              "${stModel.seconds.toString()}跳过",
                              style: TextStyle(
                                fontFamily: "FZKT",
                                fontSize: 14.sp,
                              ),
                            );
                          },
                        ),
                        onPressed: () => state.pushNewPage(context),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
