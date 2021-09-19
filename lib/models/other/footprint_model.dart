///
///author: DJT
///created on: 2021/9/4 9:05
///
import 'package:flutter_music/widget/bubble/bubble_paint.dart';

class FootprintModel {
  String assetImage;
  bool isSelect;
  ClickEffect clickEffect;

  FootprintModel(
    this.assetImage, {
    this.isSelect = false,
    this.clickEffect = ClickEffect.image,
  });
}
