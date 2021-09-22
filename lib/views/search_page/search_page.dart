import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';
import 'package:flutter_music/views/search_page/hot_search_list.dart';
import 'package:flutter_music/widget/bubble/click_effect_widget.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<SearchViewModel>().initViewModel();
    });
    context.read<SearchViewModel>().initTabController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClickEffectWidget(
      child: GestureDetector(
        onTap: () => KeyboardUtil.closeKeyboardUtil(),
        child: WillPopScope(
          onWillPop: () async => context.read<SearchViewModel>().onWillPopScope(),
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0.w,
              leading: MyElevatedButton(
                  () => context.read<SearchViewModel>().onWillPopScope() ? Navigator.pop(context) : null,
                  Icons.arrow_back),
              backgroundColor: ThemeUtil.scaffoldColor(context),
              elevation: 0,
              centerTitle: true,
              title: searchWidget(context),
            ),
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.center,
              children: [
                bodyWidget(),
                // searchWidget(context),
                Positioned(
                  bottom: MediaQueryData.fromWindow(window).padding.bottom.w + 2.w,
                  child: const PlayBarWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget() {
    SearchViewModel svModelR = context.read<SearchViewModel>();
    SearchViewModel svModelW = context.watch<SearchViewModel>();
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: SmartRefresher(
        controller: svModelW.rC,
        onRefresh: () => svModelR.onRefresh(),
        enablePullUp: svModelW.isSearchList,
        onLoading: !svModelW.isSearchList ? null : () => svModelR.onLoading(),
        child: CustomScrollView(
          // controller: svModelW.listExternalController,
          // physics: BouncingScrollPhysics(),
          slivers: [
            if (svModelW.searchHistoryList.isNotEmpty && !svModelW.isSearchList)
              SliverToBoxAdapter(
                child: Column(
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
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => MyCupertinoDialog(
                                  title: "是否清除搜索历史",
                                  onYes: () {
                                    setState(() => svModelR.clearSearchHistory());
                                    RouteUtil.pop(context);
                                  },
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
                        children: List.generate(svModelW.searchHistoryList.length, (index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onVerticalDragUpdate: (_) => svModelR.onPanCancel(index),
                            onHorizontalDragUpdate: (_) => svModelR.onPanCancel(index),
                            onLongPressMoveUpdate: (_) => false,
                            onTap: () => false,
                            onTapDown: (_) => svModelR.onPanDown(index),
                            onTapUp: (_) {
                              svModelR.onPanCancel(index);
                              svModelR.onTapUp(index);
                            },
                            onLongPressUp: () => svModelR.onPanCancel(index),
                            child: Chip(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? svModelW.searchHistoryListBool[index]
                                      ? Colors.white
                                      : Colors.grey
                                  : svModelW.searchHistoryListBool[index]
                                      ? Colors.blueGrey
                                      : Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              label: Text(
                                svModelR.searchHistoryList[index],
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark
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
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            if (!svModelW.isSearchList)
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leadingWidth: 0,
                elevation: 0,
                primary: false,
                pinned: true,
                leading: const SizedBox(),
                title: Text(
                  "热门音乐TOP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: ThemeUtil.brightness(context) == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            if (!svModelW.isSearchList) SliverToBoxAdapter(child: HotSearchList(svModelW)),
            if (svModelW.isSearchList && svModelW.smModel != null)
              SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    String albummid = svModelW.smModel!.data!.song!.list![index].albummid!.trim();
                    return ListTile(
                      dense: false,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 8.w, 4.w),
                      leading: Container(
                        margin: EdgeInsets.only(left: 20.w, top: 10.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.w),
                          child: albummid.isNotEmpty
                              ? FadeInImage.assetNetwork(
                                  placeholder: "assets/images/singer.png",
                                  image:
                                      "https://y.gtimg.cn/music/photo_new/T002R300x300M000${svModelW.smModel!.data!.song!.list![index].albummid}.jpg",
                                  fit: BoxFit.cover,
                                  width: 45.w,
                                  height: 50.w,
                                  imageErrorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
                                      Image.asset("assets/images/logo.png"),
                                )
                              : Image.asset("assets/images/singer.png", width: 45.w, height: 50.w, fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(
                        "${svModelW.smModel!.data!.song!.list![index].songname}",
                        style: TextStyle(fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 5.w, right: 18.0.w),
                        child: Text(
                          "${svModelW.smModel?.data?.song?.list?[index].singer?[0]!.name} "
                                  "${svModelW.smModel!.data!.song!.list![index].singer!.length > 1 ? "/${svModelW.smModel!.data!.song!.list![index].singer![1]!.name}" : ""}" +
                              (svModelW.smModel!.data!.song!.list![index].albumname!.trim().isNotEmpty
                                  ? ""
                                      "  - 《${svModelW.smModel!.data!.song!.list![index].albumname!.trim()}》"
                                  : ""),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ),
                      onTap: () => svModelW.getMusicVKey(
                        context,
                        svModelW.smModel!.data!.song!.list![index].albummid!.trim(),
                        svModelW.smModel!.data!.song!.list![index].songmid!,
                        svModelW.smModel!.data!.song!.list![index].songname!,
                        "${svModelW.smModel!.data!.song!.list![index].singer![0]!.name} ${svModelW.smModel!.data!.song!.list![index].singer!.length > 1 ? "/${svModelW.smModel!.data!.song!.list![index].singer![1]!.name}" : ""}",
                        "${svModelW.smModel!.data!.song!.list![index].songid}",
                      ),
                    );
                  },
                  childCount: svModelW.smModel?.data?.song?.list?.length,
                ),
                itemExtent: 75.w,
              ),
            SliverToBoxAdapter(child: SizedBox(height: 50.w))
          ],
        ),
      ),
    );
  }

  ///顶部搜索
  Widget searchWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25.w),
      padding: EdgeInsets.symmetric(vertical: 6.w),
      height: 44.w,
      child: Container(
        // margin: EdgeInsets.only(left: 10.w, right: 10.w),
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
              onSubmitted: (value) => svModel.saveHistorySearch(value),
              onChanged: (value) => setState(() {}),
              controller: svModel.textC,
              decoration: InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.fromLTRB(0, 0, 15.w, 15.w),
                border: InputBorder.none,
                suffixIcon: svModel.textC.text.isEmpty
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
    );
  }
}
