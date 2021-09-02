///
///author: DJT
///created on: 2021/8/25 10:30
///
import 'package:flutter_music/util/tools.dart';
import 'dart:ui' as ui;

class BubblePaint extends CustomPainter {
  // final List<List<Offset>> path;
  final List<ClickEffect> path;
  final ui.Image? assetImageFrame;
  final AnimationController controller;

  BubblePaint(this.path,
      {this.assetImageFrame, required this.controller});

  Paint _paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  void paint(Canvas canvas, Size size) {
    path.forEach((item) {
      // canvas.drawCircle(item.offset, 10.w, item.paint);
      // return ;
      canvas.drawImage(assetImageFrame!, item.offset.translate(-20, -20),item. paint);
    });
    if (path.length > 0) {
      bool opc = path.first.opacityChange(controller);
      if (opc) {
        path.removeAt(0);
        return;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ClickEffect {
  double opacity = 1;
  Offset offset = Offset.zero;
  Paint paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  ClickEffect(this.offset, {this.opacity = 1});

  bool opacityChange(AnimationController controller) {
    opacity = controller.value;
    if (Colors.blue.opacity - double.parse(opacity.toStringAsFixed(1)) <= 0)
      return true;
    paint = Paint()
      ..color = Colors.blue.withOpacity(
          Colors.blue.opacity - double.parse(opacity.toStringAsFixed(1)))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    return false;
  }
}
