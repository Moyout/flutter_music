import 'package:flutter_music/util/tools.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? size;

  MyElevatedButton(this.onPressed, this.icon, {this.size = 24});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        color: Theme.of(context).dividerColor,
        size: size?.w,
      ),
    );
  }
}
