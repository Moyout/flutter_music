import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/login/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<LoginViewModel>().initViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel lvModelW = context.watch<LoginViewModel>();
    LoginViewModel lvModelR = context.read<LoginViewModel>();
    return ClickEffectWidget(
      child: GestureDetector(
        onTap: () => lvModelR.onBlank(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top / 2),
                  height: 280.w,
                  color: Theme.of(context).dividerColor,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => lvModelR.setTeddyFail(),
                        child: FlareActor(
                          "assets/Teddy.flr",
                          animation: lvModelW.teddyStatus,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top / 2,
                        left: 10.w,
                        child: MyElevatedButton(
                          () => RouteUtil.pop(context),
                          Icons.arrow_back_outlined,
                          size: 32.w,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  labelPadding: EdgeInsets.symmetric(vertical: 10.w),
                  indicatorColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.blueGrey,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.blueGrey,
                  unselectedLabelColor: Colors.grey,
                  controller: lvModelW.tabController,
                  tabs: [
                    Text("注册", style: TextStyle(fontSize: 20.sp)),
                    Text("登录", style: TextStyle(fontSize: 20.sp)),
                  ],
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    // width: getDeviceWidth(context),
                    child: TabBarView(
                      controller: lvModelW.tabController,
                      children: [
                        buildRegister(lvModelW, lvModelR),
                        buildLoginWidget(lvModelW, lvModelR),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: AppUtils.getWidth(),
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom / 2),
                  child: ElevatedButton(
                    onPressed: () => lvModelR.onSubmitted(),
                    // onPressed: () {
                    //   // ScaffoldMessenger.of(context).showSnackBar(
                    //   //   SnackBar(
                    //   //     content: Text('提交成功...'),
                    //   //     backgroundColor: Colors.transparent,
                    //   //   ),
                    //   // );
                    // },
                    child: Text(
                      lvModelW.tabController!.index == 0 ? "注册" : "登录",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///注册
  Widget buildRegister(LoginViewModel lvModelW, LoginViewModel lvModelR) {
    return ListView(
      padding: EdgeInsets.all(0).add(EdgeInsets.only(top: 10.w)),
      children: [
        TextFiledWidget(
          lvModelW.textC,
          hintText: "用户名",
          helperText: lvModelW.textC.text.length >= 6 ? null : "用户名长度小于6",
          prefixIcon: Icons.person,
          onTap: () => lvModelR.onTap(),
        ),
        TextFiledWidget(
          lvModelW.textPswC,
          hintText: "密码",
          helperText: lvModelW.textPswC.text.length >= 6 ? null : "密码长度小于6",
          prefixIcon: Icons.lock_outline,
          isHide: lvModelW.isHide,
          maxLength: 16,
          onSubmitted: () => lvModelR.onBlank(context),
          onChanged: () => lvModelR.onChanged(),
          suffixIcon: InkWell(
            customBorder: StadiumBorder(),
            onTap: () => lvModelR.setHideText(),
            child: Icon(
              Icons.remove_red_eye_outlined,
              color: lvModelW.isHide ? Colors.grey : Colors.white,
            ),
          ),
        ),
        TextFiledWidget(
          lvModelW.textEmailC,
          maxLength: 20,
          hintText: "邮箱",
          helperText: isEmail(lvModelW.textEmailC.text) ? null : "邮箱格式不正确",
          prefixIcon: Icons.email,
          inputFormatter: [FilteringTextInputFormatter(RegExp("[a-zA-Z0-9@.]"), allow: true)],
          suffixIcon: InkWell(
            customBorder: StadiumBorder(),
            onTap: () => lvModelR.sendCode(),
            child: Icon(Icons.send, color: Colors.blue),
          ),
          onTap: () => lvModelR.onTap(),
        ),
        TextFiledWidget(
          lvModelW.textCodeC,
          hintText: "验证码",
          prefixIcon: Icons.format_list_numbered,
          maxLength: 6,
          inputFormatter: [FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true)],
          onTap: () => lvModelR.onTap(),
        ),
      ],
    );
  }

  ///登录
  Widget buildLoginWidget(LoginViewModel lvModelW, LoginViewModel lvModelR) {
    return ListView(
      children: [
        TextFiledWidget(
          lvModelW.textC,
          hintText: "用户名",
          helperText: lvModelW.textC.text.length >= 6 ? null : "用户名长度小于6",
          prefixIcon: Icons.person,
          onTap: () => lvModelR.onTap(),
        ),
        TextFiledWidget(
          lvModelW.textPswC,
          hintText: "密码",
          helperText: lvModelW.textPswC.text.length >= 6 ? null : "密码长度小于6",
          prefixIcon: Icons.lock_outline,
          isHide: lvModelW.isHide,
          maxLength: 16,
          onSubmitted: () => lvModelR.onBlank(context),
          onChanged: () => lvModelR.onChanged(),
          suffixIcon: InkWell(
            customBorder: StadiumBorder(),
            onTap: () => lvModelR.setHideText(),
            child: Icon(
              Icons.remove_red_eye_outlined,
              color: lvModelW.isHide ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
