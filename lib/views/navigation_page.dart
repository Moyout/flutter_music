import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_music/provider/click_effect_provider.dart';
import 'package:flutter_music/util/native/native_util.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/views/home/mv_page.dart';
import 'package:flutter_music/views/mine/person_page.dart';
import 'package:flutter_music/views/music_hall/music_hall_page.dart';
import 'package:flutter_music/widget/bubble/click_effect_widget.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NavViewModel>().checkNet();
    // AppUtils.getContext().read<ClickEffectProvider>().initAnimationController(this);
  }

  @override
  void dispose() {
    super.dispose();
    context.read<NavViewModel>().subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    NavViewModel navModel = context.read<NavViewModel>();
    navModel.initSC(context);
    context.read<PlayBarViewModel>().initViewModel();
    return ClickEffectWidget(
      child: WillPopScope(
        onWillPop: () async => NativeUtil.backToDesktop(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: Stack(
              // fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: context.watch<NavViewModel>().pageController,
                  onPageChanged: (i) => navModel.pageTo(i),
                  children: <Widget>[
                    MusicHallPage(),
                    MVPage(),
                    PersonPage(),
                  ],
                ),
                Positioned(
                  bottom: 42.w + MediaQuery.of(context).padding.bottom / 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45.w,
                    child: Consumer<NavViewModel>(
                      builder: (_, NavViewModel navModel, __) {
                        return ListView(
                          controller: navModel.sc,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(width: MediaQuery.of(context).size.width - 50.w),
                            PlayBarWidget(),
                            Container(width: 60.w),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                bottomBar(navModel, context),
                // CustomPaint(
                //   foregroundPainter: BubblePaintWidget(_path),
                //   // painter: BubblePaintWidget(_points),
                // ),
                // PlayBarWidget(model, widget.model),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///底部导航栏
  Widget bottomBar(NavViewModel navModel, BuildContext context) {
    return Positioned(
      bottom: 0.w,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(0, 2))],
        ),
        padding: EdgeInsets.all(1.5.w).add(EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom.w / 2)),
        width: AppUtils.getWidth(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              alignment: navModel.navIndex == 0
                  ? Alignment.centerLeft
                  : navModel.navIndex == 1
                      ? Alignment.center
                      : Alignment.centerRight,
              duration: Duration(milliseconds: 300),
              child: Container(
                width: 130.w,
                height: 45.w,
                decoration: BoxDecoration(
                  // color: Color(0xff123123),
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(25.w),
                ),
              ),
            ),
            ...List.generate(navModel.itemList.length, (index) {
              return Positioned(
                width: (AppUtils.getWidth() - 80.w) / 3,
                left: index == 0 ? 0 : null,
                right: index == 2 ? 0 : null,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => navModel.pageTo(index),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        navModel.itemList[index].icon,
                        color: navModel.itemList[index].isActive ? Colors.white : Colors.grey,
                        size: 22.sp,
                      ),
                      SizedBox(width: 10.w, height: 45.w),
                      Offstage(
                        offstage: !navModel.itemList[index].isActive,
                        child: Text(
                          navModel.itemList[index].title,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class BottomItem {
  final String title;
  final IconData icon;
  bool isActive;

  BottomItem(this.title, this.icon, {this.isActive = false});
}
