import 'package:flutter_music/util/tools.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickEffectWidget(
      child: Scaffold(
        body: Container(

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
