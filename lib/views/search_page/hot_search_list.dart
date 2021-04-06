import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class HotSearchList extends StatelessWidget {
  final SearchViewModel svModel;

  const HotSearchList(this.svModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12.w),
        child: svModel.hmModel?.songlist == null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                child: const CupertinoActivityIndicator(),
              )
            : ListView(
                physics: NeverScrollableScrollPhysics(),
                itemExtent: AppUtils.getHeight() * 0.76 / 10,
                children: List.generate(10, (index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                      padding: EdgeInsets.only(left: 20.w, top: 10.w),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: index == 0 || index == 1 || index == 2
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
                      ),
                    ),
                    title: Text(
                      svModel.hmModel!.songlist![index].data!.songname!,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    subtitle: Text(
                      "${svModel.hmModel!.songlist![index].data!.singer![0].name}" +
                              svModel.hmModel!.songlist![index].data!.albumdesc!,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    onTap: () => svModel.onHotSearchItem(
                        svModel.hmModel!.songlist![index].data!.songname!),
                  );
                }),
              ),
      ),
    );
  }
}
