import 'package:flutter/cupertino.dart';
import 'package:flutter_music/util/tools.dart';

class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12.w),
        child:
        // svModel.hmModel?.songlist == null?
        Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                child: const CupertinoActivityIndicator(),
              )
            // : ListView(),
      ),
    );
  }
}
