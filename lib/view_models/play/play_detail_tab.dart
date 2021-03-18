import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/play/play_page_viewmodel.dart';
import 'package:flutter_music/view_models/play/playbar_viewmodel.dart';

class PlayDetailTab extends StatefulWidget {


  @override
  _PlayDetailTabState createState() => _PlayDetailTabState();
}

class _PlayDetailTabState extends State<PlayDetailTab>
    with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<PlayPageViewModel>().initAnimationController(this);
    context.read<PlayPageViewModel>().initRecord(context);
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
    super.build(context);
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0)
                      .animate(context.watch<PlayPageViewModel>().recordC!),
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
                  onTap: () {
                    context.read<PlayPageViewModel>().controllerAnimation();
                  },
                  child: RotationTransition(
                    alignment: Alignment(0.6, -0.7),
                    // origin: Offset(10,20),
                    turns: Tween(begin: -0.08, end: 0.001).animate(
                        context.watch<PlayPageViewModel>().animationC!),
                    child: Container(
                      // color: Colors.indigoAccent,
                      height: AppUtils.getWidth(context) / 2,
                      // color: Colors.indigoAccent,
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
          Expanded(child: Text("aa"))
        ],
      ),
    );
  }

  @override
   bool get wantKeepAlive => true;
}
