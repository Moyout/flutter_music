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
  List<ClickEffectModel> footprints = [ClickEffectModel(Offset.zero)];

  void initAnimationController(TickerProvider tickerProvider) {
    controller = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  void onPointerDown(Offset offset) {
    footprints.clear();
    footprints.add(ClickEffectModel(offset));
    notifyListeners();
  }

  void onPointerMove(Offset offset) {
    if (footprints.isNotEmpty) {
      if ((offset.distance - footprints.last.offset.distance).abs() >= 20) {
        footprints.add(ClickEffectModel(offset));
        if (footprints.length > 10) footprints.removeAt(0);
      }
    } else {
      footprints.add(ClickEffectModel(offset));
    }
    notifyListeners();
  }

  void onPointerUp(Offset offset) {
    footprints.add(ClickEffectModel(offset));
    notifyListeners();
  }

  void onPointerCancel(Offset offset) {
    footprints.add(ClickEffectModel(offset));
    notifyListeners();
  }

  //方法2.2：获取本地图片 返回ui.Image 不需要传入BuildContext context
  Future<ui.Image> getAssetUiImage(String asset, {int? width, int? height}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  //获取本地图片
  void setAssetImage({String assetImagesString = "assets/images/paw.png"}) async {
    ui.Image imageFrame;
    String assetsFootprintString = SpUtil.getString(PublicKeys.assetFootprintString) ?? "";
    if (assetsFootprintString.isEmpty) {
      imageFrame = await getAssetUiImage(assetImagesString, width: 40, height: 40);
    } else {
      imageFrame = await getAssetUiImage(assetsFootprintString, width: 40, height: 40);
    }
    assetImageFrame = imageFrame;
    notifyListeners();
  }
}
