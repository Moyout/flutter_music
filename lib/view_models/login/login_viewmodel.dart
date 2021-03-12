import 'package:flutter_music/util/tools.dart';

class LoginViewModel extends ChangeNotifier {
  TabController? tabController;

  void initViewModel(TickerProvider tickerProvider) {
    if (tabController == null) {
      tabController = TabController(length: 2, vsync: tickerProvider);
    }
  }
}
