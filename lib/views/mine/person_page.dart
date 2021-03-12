import 'package:flutter/material.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/mine/login/login_page.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: SearchBarWidget(title: "我的")),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Center(
                  child: InkWell(
                    customBorder: StadiumBorder(),
                    child: Icon(
                      Icons.person_pin,
                      size: 100.w,
                      color: Theme.of(context).dividerColor,
                    ),
                    onTap: () => RouteUtil.push(context, LoginPage(),
                        animation: RouteAnimation.popDown),
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
