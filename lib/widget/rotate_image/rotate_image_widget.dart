import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/playbar/playbar_viewmodel.dart';

class RotateImageWidget extends StatefulWidget {
  @override
  _RotateImageWidgetState createState() => _RotateImageWidgetState();
}

class _RotateImageWidgetState extends State<RotateImageWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlayBarViewModel>().controller =
          AnimationController(duration: Duration(seconds: 10), vsync: this);
      context.read<PlayBarViewModel>().initViewModel();
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return context.read<PlayBarViewModel>().controller == null
        ? Container()
        : GestureDetector(
            onTap: () {},
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0)
                  .animate(context.watch<PlayBarViewModel>().controller),
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/0.gif",
                  image: "https://bing.ioliu.cn/v1/rand",
                  width: 40.w,
                  height: 40.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
}
