import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/widget/appbar/my_appbar.dart';
import 'package:flutter_music/widget/bubble/my_bubble.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBubble(
      child: Scaffold(
        appBar: MyAppBar(
          isShowLeading: false,
          title: Text(
            "播放历史",
            style: TextStyle(
                color: Theme.of(context).dividerColor, fontSize: 18.sp),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () => RouteUtil.pop(context),
          child: Text("返回"),
        ),
      ),
    );
  }
}
