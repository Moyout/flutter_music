import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/widget/search_bar/search_bar_widget.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickEffectWidget(
      child: Scaffold(
        appBar: MyAppBar(title: const SearchBarWidget()),
        body: const CustomScrollView(
          slivers: [
            // //   SliverAppBar(
            // //     backgroundColor: Colors.transparent,
            // //   elevation: 0,
            // //   floating: true,
            // //   snap: true,
            // //   // pinned: true,//固定appbars
            // // ),
            //
            // SliverList(
            //     delegate: SliverChildListDelegate([
            //   Image.asset("assets/images/0.gif")
            // ])),
            // const SliverAppBar(
            //   primary: false,
            //   backgroundColor: Colors.red,
            //   elevation: 0,
            //   // floating: true,
            //   // snap: true,
            //   pinned: true,//固定appbars
            // ),
            //
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [Text("asdasd")],
            //   ),
            // ),
            // SliverList(
            //     delegate: SliverChildListDelegate([
            //   Container(
            //     child: Image.asset("assets/images/0.gif"),
            //   )
            // ])),
            // const SliverToBoxAdapter(child: FlutterLogo(size: 80)),
            // SliverAppBar(
            //   primary: false,
            //   backgroundColor: Colors.grey,
            //   elevation: 0,
            //   // floating: true,
            //   // snap: true,
            //   pinned: true,//固定appbars
            //   title: Column(
            //     children: [
            //       Text("sadasd"),
            //       Text("sadasd"),
            //       Text("sadasd"),
            //       Text("sadasd"),
            //     ],
            //   ),
            // ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate((context, index) {
            //     return Container(
            //       height: 80,
            //       color: Colors.primaries[index % Colors.primaries.length],
            //     );
            //   }, childCount: 26),
            // ),
            // SliverToBoxAdapter(
            //   child: Placeholder(),
            // ),

            // SliverFillViewport(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return Container(
            //         height: 100,
            //         color: Colors.primaries[index % Colors.primaries.length],
            //       );
            //     },
            //     childCount: 23,
            //   ),
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            RouteUtil.pop(context);
          },
          child: const Text("返回"),
        ),
      ),
    );
  }
}
