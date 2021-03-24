import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';

class PlayLyricTab extends StatefulWidget {
  @override
  _PlayLyricTabState createState() => _PlayLyricTabState();
}

class _PlayLyricTabState extends State<PlayLyricTab> {
  @override
  void initState() {
    AppUtils.getContext().read<PlayPageViewModel>().startLyric();
    // AppUtils.getContext().read<PlayPageViewModel>().getLyric();

    super.initState();
  }

  @override
  void dispose() {
    AppUtils.getContext().read<PlayPageViewModel>().timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(bottom: 50.w),
      // margin: EdgeInsets.only(bottom: 80.w, left: 40.w, right: 40.w),
      child: ListWheelScrollView(
        overAndUnderCenterOpacity: 0.4,
        controller: context.watch<PlayPageViewModel>().sc,
        useMagnifier: true,
        magnification: 1.2,
        itemExtent: 50.w,
        children: context.watch<PlayPageViewModel>().lyrics.map((e) {
          return Text(
            e.toString(),
            style: TextStyle(
              color: context.watch<PlayPageViewModel>().negColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w900,
            ),
            overflow: TextOverflow.ellipsis,
          );
        }).toList(),
      ),
    );
  }
}
