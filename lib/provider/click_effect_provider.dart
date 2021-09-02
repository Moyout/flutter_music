///
///author: DJT
///created on: 2021/9/2 8:56
///
///
///
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/widget/bubble/bubble_paint.dart';
import 'dart:ui' as ui;

class ClickEffectProvider extends ChangeNotifier {
  late AnimationController controller;
  ui.Image? assetImageFrame; //本地图片
  List<ClickEffect> footprints = [ClickEffect(Offset.zero)];

  void initAnimationController(TickerProvider tickerProvider) {
    controller = AnimationController(
      vsync: tickerProvider,
      duration: Duration(milliseconds: 500),
    )..repeat();
  }

  void onPointerDown(Offset offset) {
    footprints.clear();
    footprints.add(ClickEffect(offset));
    notifyListeners();
  }

  void onPointerMove(Offset offset) {
    if (footprints.length > 0) {
      if ((offset.distance - footprints.last.offset.distance).abs() >= 20) {
        footprints.add(ClickEffect(offset));
        if (footprints.length > 10) footprints.removeAt(0);
      }
    } else {
      footprints.add(ClickEffect(offset));
    }
    notifyListeners();
  }

  void onPointerUp(Offset offset) {
    footprints.add(ClickEffect(offset));
    notifyListeners();
  }

  void onPointerCancel(Offset offset) {
    footprints.add(ClickEffect(offset));
    notifyListeners();
  }

  //方法2.2：获取本地图片 返回ui.Image 不需要传入BuildContext context
  Future<ui.Image> getAssetUiImage(String asset,
      {int? width, int? height}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  //获取本地图片
  void getAssetImage() async {
    ui.Image imageFrame =
        await getAssetUiImage('assets/images/paw.png', width: 40, height: 40);
    assetImageFrame = imageFrame;
    notifyListeners();
  }
}
