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
  const MusicHallPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MusicHallViewModel mHVModel = context.watch<MusicHallViewModel>();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const SearchBarWidget(title: "音乐馆"),
      ),
      body: Container(
        // color: Colors.blueGrey,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SmartRefresher(
          controller: context.watch<MusicHallViewModel>().rController,
          onRefresh: () {
            context.read<MusicHallViewModel>().getRecommendSongSheet();
            context.read<MusicHallViewModel>().getBanner();
          },
          child: context.watch<NavViewModel>().netMode == ConnectivityResult.none
              ? const Center(child: Text("请检查网络", style: TextStyle(color: Colors.red)))
              : CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: BannerWidget()),
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      titleSpacing: 10.w,
                      title: Text("推荐歌单", style: TextStyle(fontSize: 18.sp)),
                    ),
                    SliverToBoxAdapter(
                      child: mHVModel.r17model.recomPlaylist?.data == null
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                              child: const Center(child: CircularProgressIndicator()),
                            )
                          : Container(
                              alignment: Alignment.center,
                              // color: Colors.pink[200],
                              child: Wrap(
                                // alignment: WrapAlignment.spaceEvenly,
                                runSpacing: 28.w,
                                spacing: 10.w,
                                children: [
                                  ...List.generate(mHVModel.r17model.recomPlaylist!.data!.vHot!.length, (index) {
                                    return GestureDetector(
                                      onTap: () => RouteUtil.push(
                                          context,
                                          SongSheetPage(
                                              mHVModel.r17model.recomPlaylist!.data!.vHot![index].contentId!)),
                                      child: SizedBox(
                                        // height: 120.w,
                                        width: 125.w,
                                        // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                                        child: Column(
                                          children: [
                                            Material(
                                              clipBehavior: Clip.antiAlias,
                                              borderRadius: BorderRadius.circular(8.w),
                                              child: FadeInImage.assetNetwork(
                                                image: "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].cover}",
                                                fit: BoxFit.contain,
                                                placeholder: "assets/images/logo.webp",
                                              ),
                                            ),
                                            SizedBox(height: 5.w),
                                            Text(
                                              "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].title}",
                                              style: TextStyle(fontSize: 14.sp),
                                              // textAlign: TextAlign.center,
                                              // textDirection: TextDirection.ltr,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.transparent,
                        height: 60,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
