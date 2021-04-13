import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/search/search_viewmodel.dart';

class SearchList extends StatelessWidget {
  final SearchViewModel svModel;

  const SearchList(this.svModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12.w),
        child: svModel.smModel?.data == null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                child: const CupertinoActivityIndicator(),
              )
            : svModel.smModel?.data?.song?.list?.length == 0
                ? Center(child: const Text("无结果"))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemExtent: 75.w,
                          controller: svModel.listController,
                          itemCount: svModel.smModel?.data?.song?.list?.length,
                          itemBuilder: (_, index) {
                            String albummid = svModel.smModel!.data!.song!.list![index].albummid!.trim();
                            return ListTile(
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 8.w, 4.w),
                              leading: Container(
                                margin: EdgeInsets.only(left: 20.w, top: 10.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.w),
                                  child: albummid.length > 0
                                      ? FadeInImage.assetNetwork(
                                          placeholder: "assets/images/singer.png",
                                          image:
                                              "https://y.gtimg.cn/music/photo_new/T002R300x300M000${svModel.smModel!.data!.song!.list![index].albummid}.jpg",
                                          fit: BoxFit.cover,
                                          width: 45.w,
                                          height: 50.w,
                                        )
                                      : Image.asset(
                                          "assets/images/singer.png",
                                          width: 45.w,
                                          height: 50.w,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              title: Text(
                                "${svModel.smModel!.data!.song!.list![index].songname}",
                                style: TextStyle(fontSize: 14.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 5.w, right: 18.0.w),
                                child: Text(
                                  "${svModel.smModel?.data?.song?.list?[index].singer?[0]!.name} "
                                          "${svModel.smModel!.data!.song!.list![index].singer!.length > 1 ? "/${svModel.smModel!.data!.song!.list![index].singer![1]!.name}" : ""}" +
                                      "${svModel.smModel!.data!.song!.list![index].albumname!.trim().length > 0 ? ""
                                          "  - 《${svModel.smModel!.data!.song!.list![index].albumname!.trim()}》" : ""}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                ),
                              ),
                              onTap: () => svModel.getMusicVKey(
                                context,
                                svModel.smModel!.data!.song!.list![index].albummid!.trim(),
                                svModel.smModel!.data!.song!.list![index].songmid!,
                                svModel.smModel!.data!.song!.list![index].songname!,
                                "${svModel.smModel!.data!.song!.list![index].singer![0]!.name} ${svModel.smModel!.data!.song!.list![index].singer!.length > 1 ? "/${svModel.smModel!.data!.song!.list![index].singer![1]!.name}" : ""}",
                                "${svModel.smModel!.data!.song!.list![index].songid}",
                              ),
                            );
                          },
                        ),
                      ),
                      svModel.isLoading ? const CupertinoActivityIndicator() : const SizedBox(),
                    ],
                  ),
      ),
    );
  }
}
