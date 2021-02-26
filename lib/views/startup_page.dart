import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/startup_viewmodel.dart';

class StartUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StartUpViewModel state = context.read<StartUpViewModel>();
    state.initViewModel(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("https://bing.ioliu.cn/v1/rand"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.srcOver,
            ),
          ),
        ),
        width: AppUtils.getWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 50.w),
              child: Image.asset(
                "assets/images/logo.png",
                width: AppUtils.getWidth(context) / 2 - 40.w,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Image.asset(
                "assets/images/logo2.png",
                width: AppUtils.getWidth(context) / 2 - 20.w,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 10.w, right: 30.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child: RawChip(
                  backgroundColor: Colors.transparent,
                  label: Consumer<StartUpViewModel>(
                    builder: (_, StartUpViewModel stModel, __) {
                      return Text(
                        "${stModel.times.toString()}跳过",
                        style: TextStyle(
                          fontFamily: "FZKT",
                          fontSize: 14.sp,
                        ),
                      );
                    },
                  ),
                  onPressed: () => state.pushNewPage(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
