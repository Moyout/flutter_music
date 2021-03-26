import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';
import 'package:flutter_music/widget/appbar/my_appbar.dart';
import 'package:flutter_music/widget/bubble/my_bubble.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List list = SpUtil.getStringList(PublicKeys.playHistory) ?? [];
    return MyBubble(
      child: Scaffold(
        appBar: MyAppBar(
          isShowLeading: false,
          title: Text(
            "播放历史",
            style: TextStyle(
              color: Theme.of(context).dividerColor,
              fontSize: 18.sp,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () => RouteUtil.pop(context),
          child: Text("返回"),
        ),
        body: buildHistoryList(list),
      ),
    );
  }

  Widget buildHistoryList(List history) {
    List decodeList = [];
    history.forEach((element) => decodeList.add(jsonDecode(element)));
    return decodeList.length == 0
        ? Center(child: Text("空"))
        : ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: CupertinoScrollbar(
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemExtent: 50.w,
                  itemCount: decodeList.length,
                  itemBuilder: (context, index) {
                    // return Text("asdasd");
                    return ListTile(
                      selectedTileColor:
                          Theme.of(context).dividerColor.withOpacity(0.4),
                      isThreeLine: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      leading: Text(
                        "《${decodeList[index]["songName"]}》",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      selected: context
                                  .watch<PlayBarViewModel>()
                                  .playDetails[2] ==
                              decodeList[index]["songName"] &&
                          context.watch<PlayBarViewModel>().playDetails[3] ==
                              decodeList[index]["singer"],
                      subtitle: const Text(""),
                      trailing: context.watch<PlayBarViewModel>().isPlay
                          ? (context.watch<PlayBarViewModel>().playDetails[2] ==
                                      decodeList[index]["songName"] &&
                                  context
                                          .watch<PlayBarViewModel>()
                                          .playDetails[3] ==
                                      decodeList[index]["singer"]
                              ? Image.asset("assets/images/playing.webp",
                                  width: 20.w, height: 20.w)
                              : null)
                          : null,
                      title: Text(
                        "${decodeList[index]["singer"]}",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      onTap: () => context.read<SearchViewModel>().getMusicVKey(
                          context,
                          decodeList[index]["albumMid"],
                          decodeList[index]["songmid"],
                          decodeList[index]["songName"],
                          decodeList[index]["singer"]),
                    );
                  }),
            ),
          );
  }
}
