import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class SearchList extends StatefulWidget {
  final SearchViewModel svModel;

  const SearchList({Key key, this.svModel}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.svModel.initTabController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: AppUtils.getWidth(context),
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: Text(
            "热门音乐TOP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // Material(
        //   clipBehavior: Clip.antiAlias,
        //   borderRadius: BorderRadius.circular(12.w),
        //   child: widget.svModel.hmModel?.songlist == null
        //       ? Padding(
        //           padding:
        //               EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
        //           child: CupertinoActivityIndicator(),
        //         )
        //       : Column(
        //           children: List.generate(10, (index) {
        //             return ListTile(
        //               contentPadding: EdgeInsets.all(0),
        //               leading: Container(
        //                 padding: EdgeInsets.only(left: 20.w, top: 10.w),
        //                 child: Text(
        //                   "${index + 1}",
        //                   style: TextStyle(
        //                     color: index == 0 || index == 1 || index == 2
        //                         ? Colors.deepOrange
        //                         : Colors.grey,
        //                   ),
        //                 ),
        //               ),
        //               title: Text(
        //                 widget.svModel.hmModel.songlist[index].data.songname,
        //                 style: TextStyle(
        //                   color:
        //                       Theme.of(context).brightness == Brightness.light
        //                           ? Colors.black
        //                           : Colors.white,
        //                   fontSize: 14.sp,
        //                 ),
        //               ),
        //               subtitle: Text(
        //                 "${widget.svModel.hmModel.songlist[index].data.singer[0].name}" +
        //                         widget.svModel.hmModel.songlist[index].data
        //                             .albumdesc ??
        //                     "",
        //                 style: TextStyle(fontSize: 12.sp),
        //               ),
        //               onTap: () {
        //                 // model.onSongItem(
        //                 //     model.hotMusic.songlist[index].data.songname);
        //               },
        //             );
        //           }),
        //         ),
        // ),
        Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12.w),
          child: widget.svModel.hmModel?.songlist == null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.w, horizontal: 20.w),
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  children: List.generate(10, (index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        padding:
                            EdgeInsets.only(left: 20.w, top: 10.w),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: index == 0 ||
                                    index == 1 ||
                                    index == 2
                                ? Colors.deepOrange
                                : Colors.grey,
                          ),
                        ),
                      ),
                      title: Text(
                        widget.svModel.hmModel.songlist[index].data
                            .songname,
                        style: TextStyle(
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      subtitle: Text(
                        "${widget.svModel.hmModel.songlist[index].data.singer[0].name}" +
                                widget
                                    .svModel
                                    .hmModel
                                    .songlist[index]
                                    .data
                                    .albumdesc ??
                            "",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      onTap: () {
                        // model.onSongItem(
                        //     model.hotMusic.songlist[index].data.songname);
                      },
                    );
                  }),
                ),
        ),
        Container(color: Colors.brown)
      ],
    );
  }
}
