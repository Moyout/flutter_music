///
///author: DJT
///created on: 2021/9/2 9:44
///
import 'package:flutter_music/provider/click_effect_provider.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/widget/bubble/bubble_paint.dart';

class ClickEffectWidget extends StatelessWidget {
  final Widget child;

  const ClickEffectWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ClickEffectProvider>().getAssetImage();
    return Listener(
            onPointerDown: (PointerDownEvent pointerDownEvent) {
              context
                  .read<ClickEffectProvider>()
                  .onPointerDown(pointerDownEvent.localPosition);
            },
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              context
                  .read<ClickEffectProvider>()
                  .onPointerMove(pointerMoveEvent.localPosition);
            },
            onPointerUp: (PointerUpEvent pointerUpEvent) {
              context
                  .read<ClickEffectProvider>()
                  .onPointerUp(pointerUpEvent.localPosition);
            },
            onPointerCancel: (PointerCancelEvent pointerCancelEvent) {
              context
                  .read<ClickEffectProvider>()
                  .onPointerCancel(pointerCancelEvent.localPosition);
            },
            child: AnimatedBuilder(
              animation: context.watch<ClickEffectProvider>().controller,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  foregroundPainter: BubblePaint(
                    context.watch<ClickEffectProvider>().footprints,
                    assetImageFrame:
                        context.watch<ClickEffectProvider>().assetImageFrame,
                    controller: context.watch<ClickEffectProvider>().controller,
                  ),
                  child: child,
                );
              },
              child: child,
            ),
          );
  }
}
