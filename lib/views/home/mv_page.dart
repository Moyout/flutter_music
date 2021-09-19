import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/mv/mv_viewmodel.dart';
import 'package:flutter_music/view_models/nav_viewmodel.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MVPage extends StatefulWidget {
  const MVPage({Key? key}) : super(key: key);

  @override
  _MVPageState createState() => _MVPageState();
}

class _MVPageState extends State<MVPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<MvViewModel>().initViewModel();
    super.initState();
  }

  // @override
  // void dispose() {
  //   context.read<MvViewModel>().vpController.dispose();
  //   context.read<MvViewModel>().chewieController?.pause();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    MvViewModel mvModel = context.watch<MvViewModel>();
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(bottom: false, child: SearchBarWidget(title: "MV榜")),
          Expanded(
            child: SmartRefresher(
              // enablePullDown: true,
              enablePullUp: context.watch<MvViewModel>().count < 20,
              onRefresh: () => context.read<MvViewModel>().getRankListMv(),
              onLoading: () => context.read<MvViewModel>().loadMore(),

              // onOffsetChange: (bool up, double offset) {},
              controller: context.watch<MvViewModel>().reController,
              child: context.read<NavViewModel>().netMode == ConnectivityResult.none
                  ? const Center(child: Text("请检查网络", style: TextStyle(color: Colors.red)))
                  : mvModel.mvrModel != null
                      ? ListView.builder(
                          itemExtent: 240.w,
                          itemCount: context.watch<MvViewModel>().count,
                          padding: EdgeInsets.only(bottom: 30.w),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () => context.read<MvViewModel>().playMV(index),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  mvModel.isBoolList[index]
                                      // ? VideoPlayer(mvModel.vpController)
                                      ? Chewie(
                                          controller: mvModel.chewieController!,
                                          title:
                                              "《${mvModel.mvrModel!.request!.data!.rankList![index].videoInfo!.name}》 -"
                                              "  ${mvModel.mvrModel!.request!.data!.rankList![index].videoInfo!.singers![0].name}",
                                        )
                                      : Image.network(
                                          mvModel.mvrModel!.request!.data!.rankList![index].videoInfo!.coverPic!,
                                          fit: BoxFit.fitWidth,
                                        ),
                                  Positioned(
                                    top: 10.w,
                                    left: 10.w,
                                    child: Offstage(
                                      offstage: !mvModel.isBoolList[index],
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 8.w,
                                            height: 8.w,
                                            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                          ),
                                          const Text("正在播放", style: TextStyle(color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    transitionBuilder: (child, anim) {
                                      context.read<MvViewModel>().opacity = anim.value;
                                      return ScaleTransition(child: child, scale: anim);
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    child: Offstage(
                                      key: ValueKey(mvModel.isBoolList[index]),
                                      offstage: mvModel.isBoolList[index],
                                      child: Icon(
                                        mvModel.isBoolList[index]
                                            ? Icons.pause_circle_filled_rounded
                                            : Icons.play_circle_fill_rounded,
                                        size: 60,
                                        key: ValueKey(mvModel.isBoolList[index]),
                                        color: Theme.of(context).dividerColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
            ),
          ),
          Container(color: Colors.transparent, height: 50.w)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
