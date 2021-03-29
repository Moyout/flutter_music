import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';

class PlayDetailTab extends StatefulWidget {
  @override
  _PlayDetailTabState createState() => _PlayDetailTabState();
}

class _PlayDetailTabState extends State<PlayDetailTab> with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<PlayPageViewModel>().initAnimationController(this);
    context.read<PlayPageViewModel>().initRecord();
    context.read<PlayBarViewModel>().updatePlayDetails();
    context.read<PlayPageViewModel>().getLyric();
    context.read<PlayPageViewModel>().updatePaletteGenerator();
    context.read<PlayPageViewModel>().initGetCollect(context.read<PlayBarViewModel>().playDetails);
    super.initState();
  }

  @override
  void dispose() {
    AppUtils.getContext().read<PlayPageViewModel>().recordC?.stop();
    AppUtils.getContext().read<PlayPageViewModel>().animationC?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlayBarViewModel pbModelR = context.read<PlayBarViewModel>();
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(context.watch<PlayPageViewModel>().recordC!),
                  child: Container(
                    width: AppUtils.getWidth(context) / 2 + 50.w,
                    height: AppUtils.getWidth(context) / 2 + 50.w,
                    padding: EdgeInsets.all(55.w),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/record.png"),
                      ),
                    ),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      shape: CircleBorder(),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/singer.png",
                        image: context.watch<PlayBarViewModel>().picUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -10.w,
                right: 15.w,
                child: GestureDetector(
                  // onTap: () =>
                  //     context.read<PlayPageViewModel>().controllerAnimation(),
                  child: RotationTransition(
                    alignment: Alignment(0.6, -0.7),
                    // origin: Offset(10,20),
                    turns: Tween(begin: -0.08, end: 0.001).animate(context.watch<PlayPageViewModel>().animationC!),
                    child: Container(
                      height: AppUtils.getWidth(context) / 2,
                      child: Image.asset(
                        "assets/images/record_rod.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 40.w),
          Text(
            context.watch<PlayBarViewModel>().playDetails.length > 0 ? "${context.watch<PlayBarViewModel>().playDetails[2]}" : "",
            style: TextStyle(
              fontSize: 20.sp,
              color: context.watch<PlayPageViewModel>().negColor,
            ),
          ),
          SizedBox(height: 20.w),
          Text(
            context.watch<PlayBarViewModel>().playDetails.length > 0 ? "${context.watch<PlayBarViewModel>().playDetails[3]}" : "",
            style: TextStyle(
              fontSize: 18.sp,
              color: context.watch<PlayPageViewModel>().negColor,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              alignment: Alignment.bottomCenter,
              // color: Colors.indigo[200],
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyElevatedButton(
                          () => context.read<PlayPageViewModel>().setCollect(context.read<PlayBarViewModel>().playDetails),
                          Icons.favorite_outline,
                          color: context.watch<PlayPageViewModel>().isLike ? Colors.blue : null,
                        ),
                        MyElevatedButton(() {}, Icons.arrow_circle_down_rounded),
                        MyElevatedButton(() {}, Icons.comment),
                      ],
                    ),

                    ///*************************进度条***************************
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          pbModelR.position.toString().length < 8 ? "0:00" : "${pbModelR.position.toString().substring(2, 7)}",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2.w,
                            fontSize: 14.sp,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 50.w,
                          width: AppUtils.getWidth(context) * 0.6.w,
                          child: Slider(
                            inactiveColor: Colors.white.withOpacity(0.5),
                            activeColor: Colors.lightBlueAccent.withOpacity(0.5),
                            onChanged: (v) => pbModelR.setPlayProgress(v),
                            value: (pbModelR.position != null &&
                                    pbModelR.duration != null &&
                                    pbModelR.position!.inMilliseconds > 0 &&
                                    pbModelR.position!.inMilliseconds < pbModelR.duration!.inMilliseconds)
                                ? pbModelR.position!.inMilliseconds / pbModelR.duration!.inMilliseconds
                                : 0.0,
                          ),
                        ),
                        Text(
                          pbModelR.duration.toString().length < 8 ? "0:00" : pbModelR.duration.toString().substring(2, 7),
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2.w,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),

                    ///*************************end*****************************

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyElevatedButton(() {}, Icons.refresh),
                        MyElevatedButton(() => context.read<PlayPageViewModel>().preAndNextSong(isPre: true), Icons.skip_previous, size: 44.w),
                        MyElevatedButton(
                          () => context.read<PlayBarViewModel>().getNowPlayMusic(),
                          context.watch<PlayBarViewModel>().isPlay ? Icons.pause_circle_filled_rounded : Icons.play_arrow_rounded,
                          size: 50.w,
                        ),
                        MyElevatedButton(() => context.read<PlayPageViewModel>().preAndNextSong(isPre: false), Icons.skip_next, size: 44.w),
                        MyElevatedButton(() {}, Icons.menu),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
