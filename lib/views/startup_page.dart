import 'package:flutter/material.dart';
import 'package:flutter_music/util/app_util.dart';
import 'package:flutter_music/util/sp_util.dart';
import 'package:flutter_music/util/tools.dart';

class StartUpPage extends StatefulWidget {
  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  void initState() {
    // SystemUiOverlayStyle systemUiOverlayStyle =
    // SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://bing.ioliu.cn/v1/rand",
            ),
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.srcOver)
          ),
        ),
        width: AppUtils.getScreenWidth(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 50.w),
              child: Image.asset(
                "assets/images/logo.png",
                width: AppUtils.getScreenWidth() / 2 - 40.w,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Image.asset(
                "assets/images/logo2.png",
                width: AppUtils.getScreenWidth() / 2 - 20.w,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text('ss'),
            ),
          ],
        ),
      ),
    );
  }
}
