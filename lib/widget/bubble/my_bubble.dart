import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';

class MyBubble extends StatefulWidget {
  final Widget? child;

  MyBubble({this.child});

  @override
  _MyBubbleState createState() => _MyBubbleState();
}

class _MyBubbleState extends State<MyBubble> {
  Offset offset = Offset(-20, -20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (v) => setState(() => offset = v.localPosition),
      onPanUpdate: (v) => setState(() => offset = v.localPosition),
      child: Stack(
        children: [
          Positioned(child: widget.child!),
          Positioned(
            left: offset.dx - 15.w,
            top: offset.dy - 15.w,
            child: Offstage(
              offstage: !context.watch<SetViewModel>().openPaw,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).dividerColor,
                ),
                child: Image.asset(
                  "assets/images/paw.png",
                  width: 45.w,
                  height: 45.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
