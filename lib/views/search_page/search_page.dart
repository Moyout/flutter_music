import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
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
                    )
                  ],
                ),
              ),
            ),
            searchWidget(context),
            Positioned(bottom: 0, child: PlayBarWidget()),
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
        // color: Color(0xffEEEEEE),
        height: 44.w,
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: Colors.white,
                    ),
                    child: Consumer<SearchViewModel>(
                      builder: (_, SearchViewModel svModel, child) {
                        svModel.initViewModel();
                        return TextField(
                          onTap: () {
                            // SystemChannels.textInput
                            //     .invokeMethod<void>('TextInput.hide');
                          },
                          // focusNode: sHVM.textFieldNode,
                          style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontSize: 13.sp,
                          ),
                          textInputAction: TextInputAction.search,
                          onChanged: (v) {
                            svModel.onSearchChanged(v);
                            // setState(() {});
                          },
                          onEditingComplete: () {
                            // sHVM.onSearch(myKey.currentContext.size.height);
                          },
                          controller: svModel.textC,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(bottom: 12.w),
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
                      // child: TextField(
                      //   onTap: () {
                      //     // SystemChannels.textInput
                      //     //     .invokeMethod<void>('TextInput.hide');
                      //   },
                      //   // focusNode: sHVM.textFieldNode,
                      //   style: TextStyle(
                      //     textBaseline: TextBaseline.alphabetic,
                      //     fontSize: 13.sp,
                      //   ),
                      //   textInputAction: TextInputAction.search,
                      //   onChanged: (v) {
                      //     svModel.onSearchChanged(v);
                      //     // setState(() {});
                      //   },
                      //   onEditingComplete: () {
                      //     // sHVM.onSearch(myKey.currentContext.size.height);
                      //   },
                      //   controller: context.watch<SearchViewModel>().textC,
                      //   decoration: InputDecoration(
                      //     counterText: "",
                      //     contentPadding: EdgeInsets.only(bottom: 12.w),
                      //     border: InputBorder.none,
                      //     suffixIcon: context
                      //                 .watch<SearchViewModel>()
                      //                 .textC
                      //                 .text
                      //                 .length ==
                      //             0
                      //         ? null
                      //         : GestureDetector(
                      //             onTap: () => svModel.clearText(),
                      //             child: Icon(Icons.close,
                      //                 color: Colors.grey, size: 18.w),
                      //           ),
                      //     icon: Padding(
                      //       padding: EdgeInsets.only(left: 10.w),
                      //       child: Icon(
                      //         Icons.search,
                      //         color: Colors.grey[200],
                      //         size: 18.w,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
