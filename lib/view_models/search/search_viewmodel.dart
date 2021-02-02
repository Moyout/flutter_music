import 'package:flutter_music/util/tools.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();

  void onSearchChanged(String value) {
    textC.text = value;

    notifyListeners();
  }

  void initViewModel() {
    textC.selection = TextSelection(
        baseOffset: textC.text.length, extentOffset: textC.text.length);
  }

  void clearText() {
    textC.clear();
    notifyListeners();
  }
}
