import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/views/search_page/search_page.dart';

class SearchBarWidget extends StatelessWidget {
  final String title;
  final Widget? widget;

  const SearchBarWidget({this.title = "", this.widget,Key?key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(10.w),
      width: AppUtils.getWidth(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodyText2!.fontSize! + 4.sp,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => RouteUtil.push(context, const SearchPage()),
              child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                height: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, size: 18.sp, color: Colors.grey),
                    SizedBox(width: 5.w),
                    Text(
                      "搜索",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget == null ? Container() : widget!,
        ],
      ),
    );
  }
}
