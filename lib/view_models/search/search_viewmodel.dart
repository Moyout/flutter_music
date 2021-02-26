import 'package:flutter_music/util/tools.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController textC = TextEditingController();
  List searchHistoryList = [];
  List<bool> searchHistoryListBool = [];

  void initViewModel() {
    searchHistoryList =
        SpUtil.getStringList(PublicKeys.searchHistoryList) ?? [];
    searchHistoryListBool.clear();
    for (int i = 0; i < searchHistoryList.length; i++) {
      searchHistoryListBool.add(false);
    }
    notifyListeners();
  }

  void clearText() {
    textC.clear();
    notifyListeners();
  }

  void onPanDown(int index) {
    searchHistoryListBool[index] = true;
    notifyListeners();
  }

  void onPanCancel(int index) {
    searchHistoryListBool[index] = false;
    notifyListeners();
  }

  void saveHistorySearch(String value) {
    if (!searchHistoryList.contains(value)) {
      if (searchHistoryList.length >= 10) {
        searchHistoryList.removeLast();
        searchHistoryListBool.removeLast();
      }
      searchHistoryList.insert(0, value);
      searchHistoryListBool.add(false);
      print(searchHistoryList);
      SpUtil.setStringList(PublicKeys.searchHistoryList, searchHistoryList);
    }
    notifyListeners();
  }
}
