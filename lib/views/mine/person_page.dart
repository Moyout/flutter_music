import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/login/login_viewmodel.dart';
import 'package:flutter_music/views/mine/download/download_page.dart';
import 'package:flutter_music/views/mine/favorite/myfavorites_page.dart';
import 'package:flutter_music/views/mine/history/history_page.dart';
import 'package:flutter_music/views/mine/login/login_page.dart';
import 'package:flutter_music/views/mine/set/set_page.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const SearchBarWidget(title: "我的"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                      shape: const CircleBorder(),
                    ),
                    child: context.watch<LoginViewModel>().isLogin
                        ? Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              "${context.watch<LoginViewModel>().lModel.avatar}",
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return Image.asset("assets/images/login.png",
                                    width: 100.w, height: 100.w, fit: BoxFit.cover);
                              },
                            ),
                          )
                        : Icon(Icons.person_pin, size: 100.w, color: Theme.of(context).dividerColor),
                    onPressed: () => RouteUtil.push2(context, const LoginPage()),
                  ),
                ),
                if (context.watch<LoginViewModel>().isLogin)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.w),
                      child: Text(
                        context.watch<LoginViewModel>().userName,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyElevatedButton(
                        () => RouteUtil.push(context, const HistoryPage(), animation: RouteAnimation.popLeft),
                        Icons.history_outlined,
                        size: 44.w,
                      ),
                      MyElevatedButton(
                        () => RouteUtil.push(context, const MyFavoritesPage(), animation: RouteAnimation.popUp),
                        Icons.favorite,
                        size: 44.w,
                      ),
                      MyElevatedButton(
                        () => RouteUtil.push(context, const DownloadPage(), animation: RouteAnimation.popRight),
                        Icons.download_rounded,
                        size: 44.w,
                      )
                    ],
                  ),
                ),
                InkWell(
                  customBorder: const StadiumBorder(),
                  onTap: () => RouteUtil.push(context, const SetPage(), animation: RouteAnimation.popDown),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 0.w),
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          size: 24.w,
                        ),
                        SizedBox(width: 5.w),
                        const Text("设置"),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
