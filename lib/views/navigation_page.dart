import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavViewModel navModel = context.read<NavViewModel>();
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(navModel),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Stack(
          children: <Widget>[
            PageView(
              controller: context.watch<NavViewModel>().pageController,
              // onPageChanged: (i) {
              //   context.read<NavViewModel>().pageController.jumpToPage(i);
              // },
              // controller: context.watch<NavViewModel>().pageController,
              children: <Widget>[
                Container(color: Colors.teal),
                Container(color: Colors.purple),
                Container(color: Colors.purpleAccent),
                // MusicHallPage(model, widget.model),
                // HomePage(model, widget.model),
                // MinePage(model, widget.model),
              ],
            ),
            // PlayBarWidget(model, widget.model),
          ],
        ),
      ),
    );
  }

  ///底部导航栏
  Widget bottomNavigationBar(NavViewModel navModel) {
    return Container(
       child: BottomNavigationBar(
        elevation: 5,
        currentIndex: 0,
        onTap: (i) => navModel.pageTo(i),
        type: BottomNavigationBarType.fixed,
        items: navModel.itemList.map((e) {
          return BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(e.icon, size: 12.sp, color: Colors.grey),
            activeIcon: Icon(e.icon, size: 10.sp, color: Colors.blue),
            label: e.title,
          );
        }).toList(),
      ),
    );
  }
}

class BottomItem {
  final String title;
  final IconData icon;

  BottomItem(this.title, this.icon);
}
