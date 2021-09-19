import 'package:flutter_music/util/app_util.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';

class RotateImageWidget extends StatefulWidget {
  const RotateImageWidget({Key? key}) : super(key: key);


  @override
  _RotateImageWidgetState createState() => _RotateImageWidgetState();
}

class _RotateImageWidgetState extends State<RotateImageWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<PlayBarViewModel>().init(this);
  }

  @override
  void dispose() {
    AppUtils.getContext().read<PlayBarViewModel>().controller?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return context.read<PlayBarViewModel>().controller == null
        ? const SizedBox()
        : GestureDetector(
            onTap: () {},
            child: Consumer<PlayBarViewModel>(
              builder: (_, PlayBarViewModel pbModel, __) {
                return RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(pbModel.controller!),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/0.gif",
                      image: pbModel.picUrl,
                      width: 40.w,
                      height: 40.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
