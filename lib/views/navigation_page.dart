import 'package:flutter/rendering.dart';
import 'package:flutter_music/util/theme_util.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';
import 'package:flutter_music/views/mine/person_page.dart';
import 'package:flutter_music/views/music_hall/music_hall_page.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavViewModel navModel = context.read<NavViewModel>();
    navModel.initSC(context);
    context.read<PlayBarViewModel>().initViewModel();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PageView(
              controller: context.watch<NavViewModel>().pageController,
              onPageChanged: (i) => navModel.pageTo(i),
              children: <Widget>[
                MusicHallPage(),
                Container( ),
                PersonPage(),
              ],
            ),
            Positioned(
              bottom: 42.w + MediaQuery.of(context).viewPadding.bottom,
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
                        Container(
                            width: MediaQuery.of(context).size.width - 50.w),
                        PlayBarWidget(),
                        Container(width: 60.w),
                      ],
                    );
                  },
                ),
              ),
            ),
            bottomBar(navModel, context),
            // PlayBarWidget(model, widget.model),
          ],
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
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(0, 2))
          ],
        ),
        padding: EdgeInsets.all(1.5.w).add(EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom.w )),
        width: AppUtils.getWidth(context),
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
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(25.w),
                ),
              ),
            ),
            ...List.generate(navModel.itemList.length, (index) {
              return Positioned(
                width: (AppUtils.getWidth(context) - 80.w) / 3,
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
                        color: navModel.itemList[index].isActive
                            ? Colors.white
                            : Colors.grey,
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
