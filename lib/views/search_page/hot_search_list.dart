import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class HotSearchList extends StatelessWidget {
  final SearchViewModel svModel;
  const HotSearchList(this.svModel,{Key? key}) : super(key: key);

  // final SearchViewModel svModel;
  //
  // const HotSearchList(this.svModel);

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
                child: const Center(child: Text("空")),
              )
            : Column(
                // padding: EdgeInsets.zero,
                // physics: const NeverScrollableScrollPhysics(),
                // itemExtent: 62.w,
                children: List.generate(10, (index) {
                  return SizedBox(
                    height: 62.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPrimary: Colors.blue
                      ),
                      onPressed: () => svModel.onHotSearchItem(svModel.hmModel!.songlist![index].data!.songname!),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15.w, right: 20.w, top: 10.w, bottom: 10.w),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: index == 0 || index == 1 || index == 2 ? Colors.deepOrange : Colors.grey,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                svModel.hmModel!.songlist![index].data!.songname!,
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "${svModel.hmModel!.songlist![index].data!.singer![0].name}" +
                                    svModel.hmModel!.songlist![index].data!.albumdesc!,
                                style: TextStyle(fontSize: 12.sp,
                                  color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  // return ListTile(
                  //   // selected: true,
                  //    contentPadding: EdgeInsets.zero,
                  //   leading: Container(
                  //     padding: EdgeInsets.only(left: 20.w, top: 10.w),
                  //     child: Text(
                  //       "${index + 1}",
                  //       style: TextStyle(
                  //         color: index == 0 || index == 1 || index == 2 ? Colors.deepOrange : Colors.grey,
                  //       ),
                  //     ),
                  //   ),
                  //   title: Text(
                  //     svModel.hmModel!.songlist![index].data!.songname!,
                  //     style: TextStyle(
                  //       color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                  //       fontSize: 14.sp,
                  //     ),
                  //   ),
                  //   subtitle: Container(
                  //     // color: Colors.pink,
                  //     margin:   EdgeInsets.only(bottom: 10.0),
                  //     child: Text(
                  //       "${svModel.hmModel!.songlist![index].data!.singer![0].name}" +
                  //           svModel.hmModel!.songlist![index].data!.albumdesc!,
                  //       style: TextStyle(fontSize: 12.sp),
                  //     ),
                  //   ),
                  //   onTap: () => svModel.onHotSearchItem(svModel.hmModel!.songlist![index].data!.songname!),
                  // );
                }),
              ),
      ),
    );
  }
}
