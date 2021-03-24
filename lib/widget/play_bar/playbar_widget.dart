import 'package:flutter/rendering.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';
import 'package:flutter_music/views/play/play_page.dart';
import 'package:flutter_music/widget/rotate_image/rotate_image_widget.dart';

class PlayBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlayBarViewModel pbModel = context.watch<PlayBarViewModel>();
    return Hero(
      transitionOnUserGestures: true,
      tag: "playBar",
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return PlayPage();
              });
        },
        child: Container(
          // key: UniqueKey(),
          height: 45.w,
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width - 120.w,
          padding: EdgeInsets.only(left: 2.5.w, right: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45.w / 2),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotateImageWidget(),
              marquee(pbModel),
              playButton(pbModel, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget marquee(PlayBarViewModel pbModel) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160.w,
            child: Text(
              pbModel.playDetails.length > 0 ? pbModel.playDetails[2] : " ",
              // "${pbModel.playDetails[2]}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
            ),
          ),
          Container(
            width: 160.w,
            child: Text(
              pbModel.playDetails.length > 0 ? pbModel.playDetails[3] : " ",
              // "${pbModel.playDetails[3]}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11.sp, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget playButton(PlayBarViewModel pbModel, BuildContext context) {
    // GlobalKey key = GlobalKey();

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   RenderBox? renderBox = key.currentContext!.findAncestorRenderObjectOfType();
    //   var offset = renderBox?.localToGlobal(Offset.zero);
    //   print(offset);
    // });
    return GestureDetector(
      onTap: () => pbModel.getNowPlayMusic(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        // key: key,
        width: 40.w,
        height: 40.w,
        // color: Colors.red,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3.w,
                  // value: 0.5,
                  value: (pbModel.position != null &&
                          pbModel.duration != null &&
                          pbModel.position!.inMilliseconds > 0 &&
                          pbModel.position!.inMilliseconds <
                              pbModel.duration!.inMilliseconds)
                      ? pbModel.position!.inMilliseconds /
                          pbModel.duration!.inMilliseconds
                      : 0.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
            Positioned(
              width: 40.w,
              height: 40.w,
              // top: 0,
              child: Icon(
                pbModel.isPlay
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
                color: BLUE_COLOR,
                size: 32.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
