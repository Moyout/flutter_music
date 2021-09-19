import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = SpUtil.getStringList(PublicKeys.collectMusic) ?? [];
    return ClickEffectWidget(
      child: Scaffold(
        appBar: MyAppBar(
          isShowLeading: false,
          title: Text(
            "收藏列表",
            style: TextStyle(
              color: Theme.of(context).dividerColor,
              fontSize: 18.sp,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () => RouteUtil.pop(context),
          child: const Text("返回"),
        ),
        body: buildFavoritesList(list),
      ),
    );
  }

  Widget buildFavoritesList(List favorites) {
    List decodeList = [];
    for (var element in favorites) {
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
                          decodeList[index]["singer"],
                          decodeList[index]["topid"],
                      ),
                    );
                  }),
            ),
          );
  }
}
