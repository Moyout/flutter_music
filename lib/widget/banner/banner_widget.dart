import 'package:flutter_music/util/tools.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatelessWidget {
  final List _list = [
    // "",
    // "",
    // ""
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1801580324,580766531&fm=26&gp=0.jpg",
    "http://pic1.win4000.com/wallpaper/2019-11-25/5ddb9c64d2cd5.jpg",
    "http://pic1.win4000.com/wallpaper/4/5670d6c78a446.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppUtils.getWidth() * 0.8.w,
      height: AppUtils.getHeight() * 0.2.w,
      child: ClipRRect(
        child: Swiper(
          onTap: (v) {
            switch (v) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                break;
            }
          },
          autoplayDelay: 6000,
          duration: 1000,
          pagination: const SwiperPagination(alignment: Alignment.bottomCenter),
          autoplay: true,
          scale: 0.9,
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 12.w, right: 10.w, top: 10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/0.gif",
                  image: _list[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
