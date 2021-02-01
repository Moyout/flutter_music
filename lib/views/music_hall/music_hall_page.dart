import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';

class MusicHallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 5.w,
            child: PlayBarWidget(),
          ),
        ],
      ),
    );
  }
}
