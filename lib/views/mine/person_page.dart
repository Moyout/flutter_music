import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/mine/download/download_page.dart';
import 'package:flutter_music/views/mine/favorite/myfavorites_page.dart';
import 'package:flutter_music/views/mine/login/login_page.dart';
import 'package:flutter_music/views/mine/set/set_page.dart';
import 'package:flutter_music/widget/button/myelevated_button.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(bottom: false, child: SearchBarWidget(title: "我的")),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                      shape: CircleBorder(),
                    ),
                    child: Icon(
                      Icons.person_pin,
                      size: 100.w,
                      color: Theme.of(context).dividerColor,
                    ),
                    onPressed: () => RouteUtil.push2(context, LoginPage()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyElevatedButton(
                        () => RouteUtil.push(context, MyFavoritesPage(),
                            animation: RouteAnimation.popLeft),
                        Icons.favorite,
                        size: 44.w,
                      ),
                      MyElevatedButton(
                        () => RouteUtil.push(context, DownloadPage(),
                            animation: RouteAnimation.popRight),
                        Icons.download_rounded,
                        size: 44.w,
                      )
                    ],
                  ),
                ),
                InkWell(
                  customBorder: StadiumBorder(),
                  onTap: () => RouteUtil.push(context, SetPage(),
                      animation: RouteAnimation.popDown),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.w, horizontal: 0.w),
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined,size: 24.w,),
                        SizedBox(width: 5.w),
                        Text("设置"),
                        Spacer(),
                        Icon(Icons.chevron_right_rounded)
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
