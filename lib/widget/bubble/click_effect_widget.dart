///
///author: DJT
///created on: 2021/9/2 9:44
///
import 'package:flutter_music/provider/click_effect_provider.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/widget/bubble/bubble_paint.dart';

class ClickEffectWidget extends StatefulWidget {
  final Widget child;

  const ClickEffectWidget({Key? key, required this.child}) : super(key: key);

  @override
  _ClickEffectWidgetState createState() => _ClickEffectWidgetState();
}

class _ClickEffectWidgetState extends State<ClickEffectWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    AppUtils.getContext().read<ClickEffectProvider>().setAssetImage();
    AppUtils.getContext()
        .read<ClickEffectProvider>()
        .initAnimationController(this);

    super.initState();
  }

  @override
  void dispose() {
    AppUtils.getContext().read<ClickEffectProvider>().controller.stop();
    // AppUtils.getContext().read<ClickEffectProvider>().controller.dispose();
    // print("dispose----------------------------$context");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.getContext().read<ClickEffectProvider>().controller.repeat();
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
        builder: (BuildContext context, Widget? _) {

          return CustomPaint(
            foregroundPainter: BubblePaint(
              !context.watch<SetViewModel>().openPaw
                  ? []
                  : context.watch<ClickEffectProvider>().footprints,
              assetImageFrame:
                  context.watch<ClickEffectProvider>().assetImageFrame,
              controller: context.watch<ClickEffectProvider>().controller,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}
