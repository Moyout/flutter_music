import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/music_hall/musichall_viewmodel.dart';

class SongSheetPage extends StatefulWidget {
  final int contentId;

  SongSheetPage(this.contentId);

  @override
  _SongSheetPageState createState() => _SongSheetPageState();
}

class _SongSheetPageState extends State<SongSheetPage> {
  @override
  void initState() {
    context.read<MusicHallViewModel>().getSongSheetList(widget.contentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MusicHallViewModel mHVModel = context.watch<MusicHallViewModel>();
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            title: Text(
              "歌单",
              style: TextStyle(color: Theme.of(context).dividerColor),
            ),
          ),
          mHVModel.ssdModel.songlist == null
              ? Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                    child: const CupertinoActivityIndicator(),
                  ),
                )
              : Expanded(
                  child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child: CupertinoScrollbar(
                      child: ListView.builder(
                        itemExtent: 60.w,
                        itemCount: mHVModel.ssdModel.songlist?.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return ListTile(
                            minLeadingWidth: 20.w,
                            isThreeLine: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                            leading: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text("${index + 1}", style: TextStyle(fontFamily: "")),
                            ),
                            subtitle: Text(
                              "${mHVModel.ssdModel.songlist?[index].singer?[0].name}",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            title: Text(
                              "${mHVModel.ssdModel.songlist?[index].name}",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            onTap: () {},
                            onLongPress: (){},
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
