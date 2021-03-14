import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';
import 'package:flutter_music/widget/banner/banner_widget.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class MusicHallPage extends StatefulWidget {
  @override
  _MusicHallPageState createState() => _MusicHallPageState();
}

class _MusicHallPageState extends State<MusicHallPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        print(context.read<PlayBarViewModel>().audioPlayer!.state);
      },
      child: Scaffold(
        body: Container(
          // color: Colors.blueGrey,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              SafeArea(bottom: false, child: SearchBarWidget(title: "音乐馆")),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
