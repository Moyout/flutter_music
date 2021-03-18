import 'dart:ui';

import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/play_detail_tab.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/widget/button/myelevated_button.dart';

class PlayPage extends StatefulWidget {


  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<PlayPageViewModel>().initViewModel(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: FadeInImage.assetNetwork(
              height: double.infinity,
              placeholder: "assets/images/singer.png",
              image: context.watch<PlayBarViewModel>().picUrl,
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQueryData.fromWindow(window).padding.top / 1.2),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        MyElevatedButton(
                          () => RouteUtil.pop(context),
                          Icons.keyboard_arrow_down,
                          size: 34.w,
                        ),
                        Spacer(),
                        tabBar(),
                        Spacer(),
                        MyElevatedButton(
                          () {},
                          IconData(0xe6b6, fontFamily: "MyIcons"),
                          size: 20.w,
                        ),
                      ],
                    ),
                  ),
                  tabBarView(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tabBar() {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          // onTap: (v) => context.read<PlayPageViewModel>().tabC?.animateTo(v),
          labelPadding: EdgeInsets.symmetric(vertical: 10.w),
          controller: context.watch<PlayPageViewModel>().tabC,
          tabs: [Text("详情"), Text("歌词")],
        ),
      ),
    );
  }

  Widget tabBarView() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: TabBarView(
          controller: context.watch<PlayPageViewModel>().tabC,
          children: [PlayDetailTab( ), Text("2")],
        ),
      ),
    );
  }
}
