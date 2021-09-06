import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/music_hall/musichall_viewmodel.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';

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
    return ClickEffectWidget(
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: CustomScrollView(
            slivers: [
              if (mHVModel.ssdModel.cdlist != null) buildSliverAppBar(mHVModel),
              if (mHVModel.ssdModel.cdlist != null) buildSliverFixedExtentList(mHVModel),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(MusicHallViewModel mHVModel) {
    return SliverAppBar(
      elevation: 0,
      leading: MyElevatedButton(() => RouteUtil.pop(context), Icons.arrow_back_rounded),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pinned: true,
      expandedHeight: 250.0.w,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [mHVModel.bgColor, Theme.of(context).scaffoldBackgroundColor],
              stops: [0.5, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 40.w,
                  child: Image.network(
                    "${mHVModel.ssdModel.cdlist?[0].logo}",
                    width: 140.w,
                    height: 130.w,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, object, p) => Text('Failed to load image'),
                  ),
                ),
                Positioned(
                  top: 40.w,
                  right: 20.w,
                  child: Container(
                    width: 180.w,
                    child: CupertinoContextMenu(
                      actions: [
                        const SizedBox(),
                      ],
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "\t\t\t${mHVModel.ssdModel.cdlist?[0].desc}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      previewBuilder: (context, animation, child) {
                        return Material(
                          color: Colors.transparent,
                          child: Text(
                            "\t\t\t${mHVModel.ssdModel.cdlist?[0].desc}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              letterSpacing: 1.2,
                              wordSpacing: 2.2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 20.w,
                  top: 140.w,
                  child: Container(
                    width: 180.w,
                    height: 70.w,
                    // color: Colors.grey,
                    child: Wrap(
                      clipBehavior: Clip.antiAlias,
                      spacing: 10.w,
                      runSpacing: 5.w,
                      children: [
                        ...List.generate(mHVModel.ssdModel.cdlist![0].tags!.length, (index) {
                          return Chip(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            label: Text(
                              "${mHVModel.ssdModel.cdlist![0].tags![index].name}",
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          "${mHVModel.ssdModel.cdlist?[0].dissname}",
          style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 15.sp),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        // titlePadding: EdgeInsets.fromLTRB(30.w, 40.w, 30.w, 10.w),
      ),
    );
  }

  SliverFixedExtentList buildSliverFixedExtentList(MusicHallViewModel mHVModel) {
    return SliverFixedExtentList(
      itemExtent: 60.0.w,
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          return ListTile(
            minLeadingWidth: 20.w,
            isThreeLine: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            leading: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text("${index + 1}", style: TextStyle(fontFamily: "")),
            ),
            subtitle: Text(
              "${mHVModel.ssdModel.cdlist![0].songlist?[index].singer?[0].name}",
              style: TextStyle(fontSize: 12.sp),
            ),
            title: Text(
              "${mHVModel.ssdModel.cdlist![0].songlist?[index].name}",
              style: TextStyle(fontSize: 14.sp),
            ),
            selected: context.watch<PlayBarViewModel>().playDetails.length > 0
                ? context.watch<PlayBarViewModel>().playDetails[0] == mHVModel.ssdModel.cdlist![0].songlist![index].mid
                : false,
            trailing: context.watch<PlayBarViewModel>().isPlay
                ? context.watch<PlayBarViewModel>().playDetails.length > 0
                    ? (context.watch<PlayBarViewModel>().playDetails[0] ==
                            mHVModel.ssdModel.cdlist![0].songlist![index].mid
                        ? Image.asset("assets/images/playing.webp", width: 20.w, height: 20.w)
                        : null)
                    : null
                : null,
            onTap: () => context.read<MusicHallViewModel>().onTapItem(index),
          );
        },
        childCount: mHVModel.ssdModel.cdlist![0].songlist!.length,
      ),
    );
  }
}
