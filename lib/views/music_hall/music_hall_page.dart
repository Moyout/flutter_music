import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/music_hall/musichall_viewmodel.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/views/music_hall/song_sheet/song_sheet_page.dart';
import 'package:flutter_music/widget/banner/banner_widget.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicHallPage extends StatefulWidget {
  @override
  _MusicHallPageState createState() => _MusicHallPageState();
}

class _MusicHallPageState extends State<MusicHallPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // webSocket();
    context.read<MusicHallViewModel>().initViewModel();
  }

  // webSocket() {
  //   var channel = IOWebSocketChannel.connect(Uri.parse('ws://www.moyou.website:9527/websocket/moyou'));
  //
  //   channel.stream.listen((message) {
  //     channel.sink.add('received!');
  //
  //     channel.sink.close(message.goingAway);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MusicHallViewModel mHVModel = context.watch<MusicHallViewModel>();
    return Scaffold(
      body: Container(
        // color: Colors.blueGrey,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            SafeArea(bottom: false, child: SearchBarWidget(title: "音乐馆")),
            Expanded(
              child: SmartRefresher(
                controller: context.watch<MusicHallViewModel>().rController,
                onRefresh: () {
                  context.read<MusicHallViewModel>().getRecommendSongSheet();
                  context.read<MusicHallViewModel>().getBanner();
                },
                child: SingleChildScrollView(
                  child: context.read<NavViewModel>().netMode == ConnectivityResult.none
                      ? Center(child: Text("请检查网络", style: TextStyle(color: Colors.red)))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BannerWidget(),
                            Column(
                              children: [
                                mHVModel.r17model.recomPlaylist?.data == null
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                                        child: Center(child: CircularProgressIndicator()),
                                      )
                                    : Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          ...List.generate(mHVModel.r17model.recomPlaylist!.data!.vHot!.length,
                                              (index) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () => RouteUtil.push(
                                                    context,
                                                    SongSheetPage(mHVModel
                                                        .r17model.recomPlaylist!.data!.vHot![index].contentId!)),
                                                child: Container(
                                                  height: 180.w,
                                                  width: 180.w,
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                                                  child: Stack(
                                                    children: [
                                                      FadeInImage.assetNetwork(
                                                        image:
                                                            "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].cover}",
                                                        fit: BoxFit.contain,
                                                        placeholder: "assets/images/logo.webp",
                                                      ),
                                                      Text(
                                                        "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].title}",
                                                        style: TextStyle(fontSize: 14.sp),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                              ],
                            ),
                            SizedBox(height: 50)
                          ],
                        ),
                ),
              ),
            ),
            // Expanded(
            //   child: SmartRefresher(
            //     controller: context.watch<MusicHallViewModel>().rController,
            //     onRefresh: () {
            //       context.read<MusicHallViewModel>().getRecommendSongSheet();
            //     },
            //     child: context.read<NavViewModel>().netMode == ConnectivityResult.none
            //         ? Center(child: Text("请检查网络", style: TextStyle(color: Colors.red)))
            //         : SingleChildScrollView(
            //             // physics: BouncingScrollPhysics(),
            //             child: Column(
            //               children: [
            //                 mHVModel.r17model.recomPlaylist?.data == null
            //                     ? Padding(
            //                         padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            //                         child: Center(child: Text("歌单加载失败，下拉刷新")),
            //                       )
            //                     : Wrap(
            //                         alignment: WrapAlignment.center,
            //                         children: [
            //                           ...List.generate(mHVModel.r17model.recomPlaylist!.data!.vHot!.length, (index) {
            //                             return Material(
            //                               color: Colors.transparent,
            //                               child: InkWell(
            //                                 onTap: () => RouteUtil.push(
            //                                     context,
            //                                     SongSheetPage(
            //                                         mHVModel.r17model.recomPlaylist!.data!.vHot![index].contentId!)),
            //                                 child: Container(
            //                                   height: 180.w,
            //                                   width: 180.w,
            //                                   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            //                                   child: Stack(
            //                                     children: [
            //                                       FadeInImage.assetNetwork(
            //                                         image:
            //                                             "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].cover}",
            //                                         fit: BoxFit.contain,
            //                                         placeholder: "assets/images/logo.webp",
            //                                       ),
            //                                       Text(
            //                                         "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].title}",
            //                                         style: TextStyle(fontSize: 14.sp),
            //                                         textAlign: TextAlign.center,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                               ),
            //                             );
            //                           }),
            //                         ],
            //                       ),
            //               ],
            //             ),
            //           ),
            //   ),
            // ),
            // SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
