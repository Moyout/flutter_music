import 'package:flutter_music/util/tools.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final IconData? icon;
  final double? size;
  final Color? color;

  MyElevatedButton(this.onPressed, this.icon, {this.size = 24, this.color, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shape: const CircleBorder(),
        padding: EdgeInsets.all(15.w),
        shadowColor: Colors.white,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: color ?? Theme.of(context).dividerColor,
        size: size?.w,
      ),
    );
  }
}
