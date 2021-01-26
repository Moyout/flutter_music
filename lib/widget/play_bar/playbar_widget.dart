import 'package:flutter_music/util/tools.dart';
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RotateImageWidget(),

          ],
        ),
      ),
    );
  }
}
