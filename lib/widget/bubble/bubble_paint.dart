///
///author: DJT
///created on: 2021/8/25 10:30
///
import 'dart:ui';

import 'package:flutter_music/models/other/footprint_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'dart:ui' as ui;
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';

///[ClickEffect]
/// [ordinaryImage]普通图片效果
///[waterRipple] 水波纹效果
enum ClickEffect {
  image,
  waterRipple,
}

class BubblePaint extends CustomPainter {
  // final List<List<Offset>> path;
  final List<ClickEffectModel> path;
  final ui.Image? assetImageFrame;
  final AnimationController controller;

  BubblePaint(this.path, {this.assetImageFrame, required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    AppUtils.getContext().read<SetViewModel>().footprints.forEach((FootprintModel footItem) {
      if (footItem.clickEffect == ClickEffect.waterRipple && footItem.isSelect) {
        for (var item in path) {
          // canvas.drawPoints(PointMode.points, [item.offset], item.paint..strokeWidth=20.w);
          canvas.drawCircle(item.offset, 10.w * controller.value, item.paint);
          canvas.drawCircle(
            item.offset,
            14.w * controller.value,
            item.paint
              ..color = item.paint.color.withOpacity(0.2)
              ..strokeWidth = 8.w,
          );
          // return ;
          // canvas.drawImage(assetImageFrame!, item.offset.translate(-20, -20), item.paint);
        }
      } else if (footItem.isSelect) {
        for (ClickEffectModel item in path) {
          canvas.drawImage(assetImageFrame!, item.offset.translate(-20, -20), item.paint);
        }
      }
    });
    // path.forEach((item) {
    //   // canvas.drawCircle(item.offset, 10.w, item.paint);
    //   // return ;
    //   canvas.drawImage(assetImageFrame!, item.offset.translate(-20, -20), item.paint);
    // });
    if (path.isNotEmpty) {
      bool opc = path.first.opacityChange(controller);
      if (opc) {
        path.removeAt(0);
        return;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // return path.length == 0 ? false : true;
    return true;
  }
}

class ClickEffectModel {
  double opacity = 1;
  Offset offset = Offset.zero;
  Paint paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  ClickEffectModel(this.offset, {this.opacity = 1});

  bool opacityChange(AnimationController controller) {
    opacity = controller.value;
    paint = Paint()
      ..color = Colors.blue.withOpacity(Colors.blue.opacity - double.parse(opacity.toStringAsFixed(1)))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    if (Colors.blue.opacity - double.parse(opacity.toStringAsFixed(1)) <= 0) return true;

    return false;
  }
}
