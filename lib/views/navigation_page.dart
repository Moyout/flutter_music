import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/views/music_hall/music_hall_page.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavViewModel navModel = context.read<NavViewModel>();
    return Scaffold(
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PageView(
              controller: context.watch<NavViewModel>().pageController,
              onPageChanged: (i) => navModel.pageTo(i),
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      RouteUtil.push(CustomRoute(MusicHallPage()));
                    },
                    child: Container(color: Colors.teal)),
                Container(color: Colors.purple),
                Container(color: Colors.purpleAccent),
                // MusicHallPage(model, widget.model),
                // HomePage(model, widget.model),
                // MinePage(model, widget.model),
              ],
            ),
            PlayBarWidget(),
            bottomBar(navModel),
            // PlayBarWidget(model, widget.model),
          ],
        ),
      ),
    );
  }

  ///底部导航栏
  Widget bottomBar(NavViewModel navModel) {
    return Positioned(
      bottom: 35.w,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.px),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2), offset: Offset(0, 2)),
            ]),
        padding: EdgeInsets.all(1.5.w),
        width: AppUtils.getScreenWidth() - 80.w,
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
                  borderRadius: BorderRadius.circular(14.px),
                ),
              ),
            ),
            ...List.generate(navModel.itemList.length, (index) {
              return Positioned(
                width: (AppUtils.getScreenWidth() - 80.w) / 3,
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
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: "FZKT",
                          ),
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
