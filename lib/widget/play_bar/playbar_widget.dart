import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';
import 'package:flutter_music/widget/rotate_image/rotate_image_widget.dart';

class PlayBarWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    PlayBarViewModel pbModel = context.watch<PlayBarViewModel>();
    return Hero(
      tag: "playBar",
      child: Container(
        key: UniqueKey(),
        height: 45.w,
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
            marquee(),
            playButton(pbModel, context),
          ],
        ),
      ),
    );
  }

  Widget marquee() {
    return Container();
  }

  Widget playButton(PlayBarViewModel pbModel, BuildContext context) {
    return GestureDetector(
      onTap: () => pbModel.getNowPlayMusic(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
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
