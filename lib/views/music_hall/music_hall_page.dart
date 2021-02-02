import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/widget/banner/banner_widget.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class MusicHallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.blueGrey,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            SafeArea(child: SearchBarWidget(title: "音乐馆")),
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    BannerWidget(),
                    Container(height: 800),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
