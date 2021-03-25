import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';
import 'package:flutter_music/views/search_page/hot_search_list.dart';
import 'package:flutter_music/views/search_page/search_list.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<SearchViewModel>().initViewModel();
    });
    context.read<SearchViewModel>().initTabController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyBubble(
      child: GestureDetector(
        onTap: () => KeyboardUtil.closeKeyboardUtil(),
        child: WillPopScope(
          onWillPop: () async => context.read<SearchViewModel>().onWillPopScope(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  bodyWidget(),
                  searchWidget(context),
                  Positioned(
                    bottom:
                        MediaQueryData.fromWindow(window).padding.bottom.w + 2.w,
                    child: PlayBarWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget() {
    SearchViewModel svModelR = context.read<SearchViewModel>();
    SearchViewModel svModelW = context.watch<SearchViewModel>();
    return Container(
      margin: EdgeInsets.only(top: 50.w, bottom: 50.w),
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView(
          controller: svModelW.listExternalController,
          // physics: BouncingScrollPhysics(),
          physics: svModelW.tabController?.index == 0
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          children: [
            if (svModelW.searchHistoryList.length > 0 &&
                svModelW.tabController!.index == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: <Widget>[
                        const Text(
                          "最近搜索",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (_) => MyCupertinoDialog(
                                () => setState(
                                    () => svModelR.clearSearchHistory()),
                                title: "是否清除搜索历史",
                              ),
                            );
                          },
                          child: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Wrap(
                      spacing: 20.w,
                      runSpacing: 10.w,
                      children: List.generate(svModelW.searchHistoryList.length,
                          (index) {
                        return GestureDetector(
                          onPanDown: (_) => svModelR.onPanDown(index),
                          onPanCancel: () => svModelR.onPanCancel(index),
                          onHorizontalDragCancel: () => false,
                          onTap: () => false,
                          child: Chip(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? svModelW.searchHistoryListBool[index]
                                        ? Colors.white
                                        : Colors.grey
                                    : svModelW.searchHistoryListBool[index]
                                        ? Colors.blueGrey
                                        : Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            label: Text(
                              "${svModelR.searchHistoryList[index]}",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? svModelW.searchHistoryListBool[index]
                                        ? Colors.grey
                                        : Colors.white
                                    : svModelW.searchHistoryListBool[index]
                                        ? Colors.white
                                        : Colors.blueGrey,
                                fontSize: 14.w,
                                letterSpacing: 1.2,
                              ),
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            // SearchList(svModel: svModelW)
            Column(
              children: <Widget>[
                Container(
                  width: AppUtils.getWidth(context),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.w, horizontal: 15.w),
                  child: Text(
                    svModelR.tabController?.index == 0 ? "热门音乐TOP" : "搜索结果",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (svModelW.tabController != null)
                  Container(
                    height: AppUtils.getHeight(context) * 0.76,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: svModelW.tabController,
                      children: [HotSearchList(svModelW), SearchList(svModelW)],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///顶部搜索
  Widget searchWidget(BuildContext context) {
    return Positioned(
      top: MediaQueryData.fromWindow(window).padding.top,
      child: Container(
        color: ThemeUtil.scaffoldColor(context),
        width: AppUtils.getWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
        height: 44.w,
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: Colors.white,
                    ),
                    child: Consumer<SearchViewModel>(
                      builder: (_, SearchViewModel svModel, child) {
                        return TextField(
                          style: TextStyle(
                            color: Colors.blue,
                            textBaseline: TextBaseline.alphabetic,
                            fontSize: 13.sp,
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) =>
                              svModel.saveHistorySearch(value),
                          onChanged: (value) => setState(() {}),
                          controller: svModel.textC,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.fromLTRB(0, 0, 15.w, 15.w),
                            border: InputBorder.none,
                            suffixIcon: svModel.textC.text.length == 0
                                ? null
                                : GestureDetector(
                                    onTap: () => svModel.clearText(),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 18.w,
                                    ),
                                  ),
                            icon: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[200],
                          size: 18.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
