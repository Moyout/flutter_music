import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/mv/mv_viewmodel.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MVPage extends StatefulWidget {
  @override
  _MVPageState createState() => _MVPageState();
}

class _MVPageState extends State<MVPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<MvViewModel>().initViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(bottom: false, child: SearchBarWidget(title: "MV榜")),
          Expanded(
            child: SmartRefresher(
              // enablePullDown: true,
              enablePullUp: context.watch<MvViewModel>().count < 20,
              onRefresh: () => context.read<MvViewModel>().getRankListMv(),
              onLoading: () => context.read<MvViewModel>().loadMore(),
              onOffsetChange: (bool up, double offset) {},
              controller: context.watch<MvViewModel>().reController,
              child: ListView.builder(
                itemExtent: 100,
                itemCount: context.watch<MvViewModel>().count,
                padding: EdgeInsets.only(bottom: 30),
                itemBuilder: (_, index) {
                  return Text("$index");
                },
              ),
            ),
          ),
          Container(color: Colors.transparent, height: 50.w)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
