import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';

class MyCupertinoDialog extends StatelessWidget {
  final String title, content, yes, no;
  final Function function;

  const MyCupertinoDialog(
    this.function, {
    this.title = "标题",
    this.content = "",
    this.yes = "确认",
    this.no = "取消",
  });

  @override
  Widget build(BuildContext context) {
    return MyBubble(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontFamily: "FZKT"),
          ),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                yes,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontFamily: "FZKT",
                ),
              ),
              onPressed: () {
                function();
                print('yes...');
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                no,
                style: TextStyle(
                  fontFamily: "FZKT",
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
