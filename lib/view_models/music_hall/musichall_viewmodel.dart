
import 'package:flutter_music/models/music_hall/songsheet_detailed_model.dart';
import 'package:flutter_music/models/music_hall/songsheet_model/recommend_songsheet_model.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class MusicHallViewModel extends ChangeNotifier {
  RecommendSongSheetModel r17model = RecommendSongSheetModel();
  SongSheetDetailedModel ssdModel = SongSheetDetailedModel();
  PaletteGenerator? paletteGenerator;
  Color bgColor = Color(0xffffffff);

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
      if (value.cdlist![0].songlist != null) ssdModel = value;
      notifyListeners();
    }).then((value) {
      updatePaletteGenerator();
    });
  }

  ///图片背景色
  void updatePaletteGenerator() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage("${ssdModel.cdlist![0].logo}"),
        maximumColorCount: 15,
      );
      bgColor = paletteGenerator!.dominantColor!.color;
      notifyListeners();
    });
  }

  void onTapItem(int index) {
    AppUtils.getContext().read<SearchViewModel>().getMusicVKey(
          AppUtils.getContext(),
          "${ssdModel.cdlist![0].songlist![index].album?.mid}",
          "${ssdModel.cdlist![0].songlist![index].mid}",
          "${ssdModel.cdlist![0].songlist![index].title}",
          "${ssdModel.cdlist![0].songlist![index].singer?[0].name}",
        );
  }
}
