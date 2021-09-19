import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/music_hall/musichall_viewmodel.dart';
import 'package:flutter_music/widget/webview/webview_widget.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  // final List _list = [
  //   // "",
  //   // "",
  //   // ""
  //   "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1801580324,580766531&fm=26&gp=0.jpg",
  //   "http://pic1.win4000.com/wallpaper/2019-11-25/5ddb9c64d2cd5.jpg",
  //   "http://pic1.win4000.com/wallpaper/4/5670d6c78a446.jpg"
  // ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.grey,
      // width: AppUtils.getWidth() * 0.8.w,
      height: 180.w,
      child: ClipRRect(
        child: Swiper(
          onTap: (int index) {
            RouteUtil.push(
                context,
                WebViewWidget(
                  // title: context.read<MusicHallViewModel>().bannerModel.data![index].title!,
                  title: "",
                  url: context.read<MusicHallViewModel>().bannerModel.data?[index].h5url ?? "https://y.qq.com/",
                ));
          },
          autoplayDelay: 6000,
          duration: 1000,
          pagination: const SwiperPagination(alignment: Alignment.bottomCenter),
          autoplay: true,
          scale: 0.8,
          itemCount: context.watch<MusicHallViewModel>().bannerModel.data == null
              ? 3
              : context.watch<MusicHallViewModel>().bannerModel.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/0.gif",
                  image: context.watch<MusicHallViewModel>().bannerModel.data == null
                      ? "https://img0.baidu.com/it/u=1321929678,3997416803&fm=26&fmt=auto   "
                      : context.watch<MusicHallViewModel>().bannerModel.data![index].picUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
