import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    List list = SpUtil.getStringList(PublicKeys.playHistory) ?? [];
    return ClickEffectWidget(
      child: Scaffold(
        appBar: MyAppBar(
          isShowLeading: false,
          title: GestureDetector(
            onTap: !(list.isNotEmpty)
                ? null
                : () => showDialog(
                      context: context,
                      builder: (context) => MyCupertinoDialog(title: "清除播放历史", onYes: clearList),
                    ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("播放历史", style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 18.sp)),
                list.isNotEmpty ? Icon(Icons.cleaning_services_rounded, size: 16.sp) : const Text("")
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () => RouteUtil.pop(context),
          child: const Text("返回"),
        ),
        body: buildHistoryList(list),
      ),
    );
  }

  void clearList() async {
    await SpUtil.remove(PublicKeys.playHistory);
    setState(() {});
    RouteUtil.pop(context);
  }

  Widget buildHistoryList(List history) {
    List decodeList = [];
    for (var element in history) {
      decodeList.add(jsonDecode(element));
    }
    return decodeList.isEmpty
        ? const Center(child: Text("空"))
        : ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: CupertinoScrollbar(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemExtent: 50.w,
                  itemCount: decodeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      selectedTileColor: Theme.of(context).dividerColor.withOpacity(0.4),
                      isThreeLine: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      leading: Text(
                        "《${decodeList[index]["songName"]}》",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      subtitle: const Text(""),

                      ///*****************************当前播放判断*****************
                      selected: context.watch<PlayBarViewModel>().playDetails[2] == decodeList[index]["songName"] &&
                          context.watch<PlayBarViewModel>().playDetails[3] == decodeList[index]["singer"],
                      trailing: context.watch<PlayBarViewModel>().isPlay
                          ? (context.watch<PlayBarViewModel>().playDetails[2] == decodeList[index]["songName"] &&
                                  context.watch<PlayBarViewModel>().playDetails[3] == decodeList[index]["singer"]
                              ? Image.asset("assets/images/playing.webp", width: 20.w, height: 20.w)
                              : null)
                          : null,

                      ///********************************************************
                      title: Text(
                        "${decodeList[index]["singer"]}",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      onTap: () => context.read<SearchViewModel>().getMusicVKey(
                            context,
                            decodeList[index]["albumMid"],
                            decodeList[index]["songmid"],
                            decodeList[index]["songName"],
                            decodeList[index]["singer"],
                            decodeList[index]["topid"],
                          ),
                    );
                  }),
            ),
          );
  }
}
