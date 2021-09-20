import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/view_models/startup_viewmodel.dart';
import 'package:flutter_music/views/mine/set/set_page.dart';
import 'package:flutter_music/views/search_page/search_page.dart';
import 'package:quick_actions/quick_actions.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  String shortcut = 'no action set';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
      RouteUtil.push(context, const SearchPage());
      debugPrint("shortcut------------------------>$shortcut");
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Action one',
        icon: 'AppIcon',
      ),
      // NOTE: This second action icon will only work on Android.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(type: 'action_two', localizedTitle: 'Action two1', icon: 'ic_launcher'),
      const ShortcutItem(type: 'action_two2', localizedTitle: 'Action two2', icon: 'ic_launcher2'),
      const ShortcutItem(type: 'action_two3', localizedTitle: '搜索歌曲', icon: 'launcher_icon'),
    ]).then((value) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    KeyboardUtil.closeKeyboardUtil();
    StartUpViewModel state = context.read<StartUpViewModel>();
    state.initViewModel(context);
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
                child: RawChip(
                  backgroundColor: Colors.transparent,
                  label: Consumer<StartUpViewModel>(
                    builder: (_, StartUpViewModel stModel, __) {
                      return Text(
                        "${stModel.times.toString()}跳过",
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
