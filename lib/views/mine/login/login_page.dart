import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/login/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<LoginViewModel>().initViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top / 2),
              height: 280.w,
              color: Theme.of(context).dividerColor,
              child: FlareActor(
                "assets/Teddy.flr",
                animation: "idle",
                fit: BoxFit.cover,
              ),
            ),
            TabBar(
              labelPadding: EdgeInsets.symmetric(vertical: 10.w),
              indicatorColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.blueGrey,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.blueGrey,
              unselectedLabelColor: Colors.grey,
              controller: context.watch<LoginViewModel>().tabController,
              tabs: [
                Text("注册", style: TextStyle(fontSize: 20.sp)),
                Text("登录", style: TextStyle(fontSize: 20.sp)),
              ],
            ),
            Expanded(
              child: Container(
                // width: getDeviceWidth(context),
                child: TabBarView(
                  controller: context.watch<LoginViewModel>().tabController,
                  children: [Text("1"), Text("2")],
                ),
              ),
            ),
            Container(
              width: AppUtils.getWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom / 2),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("确定"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
