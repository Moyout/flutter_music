import 'package:flutter/cupertino.dart';
import 'package:flutter_music/models/music_hall/songsheet_model/recommend_songsheet_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/music_hall/musichall_viewmodel.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';
import 'package:flutter_music/views/music_hall/song_sheet/song_sheet_page.dart';
import 'package:flutter_music/widget/banner/banner_widget.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class MusicHallPage extends StatefulWidget {
  @override
  _MusicHallPageState createState() => _MusicHallPageState();
}

class _MusicHallPageState extends State<MusicHallPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<MusicHallViewModel>().initViewModel();
  }

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
              child: mHVModel.r17model.recomPlaylist?.data == null
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                      child: const CupertinoActivityIndicator(),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ...List.generate(mHVModel.r17model.recomPlaylist!.data!.vHot!.length, (index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => RouteUtil.push(context,
                                    SongSheetPage(mHVModel.r17model.recomPlaylist!.data!.vHot![index].contentId!)),
                                child: Container(
                                  height: 180.w,
                                  width: 180.w,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                                  child: Stack(
                                    children: [
                                      FadeInImage.assetNetwork(
                                        image: "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].cover}",
                                        fit: BoxFit.contain,
                                        placeholder: "assets/images/0.gif",
                                      ),
                                      Text(
                                        "${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].title}",
                                        style: TextStyle(fontSize: 14.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                      // Positioned(
                                      //   bottom: -10.w,
                                      //   right: -10.w,
                                      //   child: MyElevatedButton(() {}, Icons.play_circle_filled_outlined),
                                      // ),
                                      // Positioned(
                                      //   bottom: 10.w,
                                      //   left: 10.w,
                                      //   child: Text(
                                      //     "播放量${mHVModel.r17model.recomPlaylist!.data?.vHot?[index].listenNum}",
                                      //     style: TextStyle(fontSize: 12.sp),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
