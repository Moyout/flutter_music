import 'package:flutter_music/util/tools.dart';

class PlayBarViewModel extends ChangeNotifier {
  AnimationController controller;

  void initViewModel() {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      }
    });
  }

}
