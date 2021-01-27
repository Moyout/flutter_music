import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';
import 'package:flutter_music/widget/rotate_image/rotate_image_widget.dart';

class PlayBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.only(left: 5.w, right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            RotateImageWidget(),
            Spacer(),
            playButton(context),
          ],
        ),
      ),
    );
  }

  Widget playButton(BuildContext context) {
    PlayBarViewModel pbModel = context.watch<PlayBarViewModel>();
    return GestureDetector(
      onTap: () {
        context.read<PlayBarViewModel>().onPlay();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              // value: 0.5,
              value: (pbModel.position != null &&
                      pbModel.duration != null &&
                      pbModel.position.inMilliseconds > 0 &&
                      pbModel.position.inMilliseconds <
                          pbModel.duration.inMilliseconds)
                  ? pbModel.position.inMilliseconds /
                      pbModel.duration.inMilliseconds
                  : 0.0,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Icon(
            pbModel.isPlay
                ? Icons.pause_circle_outline
                : Icons.play_circle_outline,
            color: BLUE_COLOR,
            size: 30.sp,
          ),
        ],
      ),
    );
  }
}
