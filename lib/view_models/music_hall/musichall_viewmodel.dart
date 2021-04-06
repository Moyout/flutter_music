import 'package:flutter_music/models/music_hall/songsheet_detailed_model.dart';
import 'package:flutter_music/models/music_hall/songsheet_model/recommend_songsheet_model.dart';
import 'package:flutter_music/util/tools.dart';

class MusicHallViewModel extends ChangeNotifier {
  RecommendSongSheetModel r17model = RecommendSongSheetModel();
  SongSheetDetailedModel ssdModel = SongSheetDetailedModel();

  ///初始化
  void initViewModel() {
    getRecommendSongSheet();
  }

  ///获取推荐歌单
  void getRecommendSongSheet() async {
    await RecommendSongSheetRequest.getSongSheet().then((value) {
      if (value.recomPlaylist?.data?.vHot != null) r17model = value;
      notifyListeners();
    });
  }

  ///获取歌单列表
  void getSongSheetList(int id) async {
    await SongSheetDetailedRequest.getSongSheetList(id).then((value) {
      if (value.songlist != null) ssdModel = value;
      notifyListeners();
    });
  }


}
