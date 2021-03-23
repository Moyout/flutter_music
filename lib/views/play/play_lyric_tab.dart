import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';

class PlayLyricTab extends StatefulWidget {
  @override
  _PlayLyricTabState createState() => _PlayLyricTabState();
}

class _PlayLyricTabState extends State<PlayLyricTab> {
  @override
  void initState() {
    context.read<PlayPageViewModel>().startLyric();
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
      margin: EdgeInsets.only(bottom: 100.w, left: 40.w, right: 40.w),
      child: ListWheelScrollView(
        overAndUnderCenterOpacity: 0.6,
        controller: context.watch<PlayPageViewModel>().sc,
        useMagnifier: true,
        magnification: 1.4,
        itemExtent: 50.w,
        children: context.watch<PlayPageViewModel>().lyrics.map((e) {
          return Text(
            e.toString(),
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
            overflow: TextOverflow.ellipsis,
          );
        }).toList(),
      ),
    );
  }
}
