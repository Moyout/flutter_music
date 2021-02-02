

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 14.sp),
        ),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(yes),
            onPressed: () {
              function();
              print('yes...');
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(no),
            onPressed: () {
              print('no...');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
