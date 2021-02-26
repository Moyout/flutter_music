import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/keyboard_util.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';
import 'package:flutter_music/widget/common/cuper_dialog.dart';
import 'package:flutter_music/widget/play_bar/playbar_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchViewModel>().clearText();
      context.read<SearchViewModel>().initViewModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.closeKeyboardUtil(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              bodyWidget(),
              searchWidget(context),
              Positioned(bottom: 0, child: PlayBarWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyWidget() {

    return Container(
      margin: EdgeInsets.only(top: 70.w, bottom: 40.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView(
          children: [
            Row(
              children: <Widget>[
                Text(
                  "搜索历史",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (_) {
                        return MyCupertinoDialog(
                          () {},
                          title: "是否清除搜索历史",
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            Divider(),
            Container(
              child: Wrap(
                spacing: 20.w,
                runSpacing: 10.w,
                children: List.generate(
                    context.watch<SearchViewModel>().searchHistoryList.length,
                    (index) {
                  return GestureDetector(
                    onPanDown: (_) =>
                        context.read<SearchViewModel>().onPanDown(index),
                    onPanCancel: () {
                      context.read<SearchViewModel>().onPanCancel(index);
                    },
                    onHorizontalDragCancel: () => false,
                    child: Chip(
                      backgroundColor: context
                              .watch<SearchViewModel>()
                              .searchHistoryListBool[index]
                          ? Colors.blueGrey
                          : Theme.of(context).brightness != Brightness.dark
                              ? Colors.grey
                              : Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      label: Text(
                        "${context.read<SearchViewModel>().searchHistoryList[index]}",
                        style: TextStyle(
                            fontFamily: "",
                            color: context
                                    .watch<SearchViewModel>()
                                    .searchHistoryListBool[index]
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14.w,
                            letterSpacing: 1.2),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  );
                }),
              ),
            )
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
                  child: Icon(Icons.arrow_back),
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
                          onSubmitted: (value) {
                            context
                                .read<SearchViewModel>()
                                .saveHistorySearch(value);
                          },
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
