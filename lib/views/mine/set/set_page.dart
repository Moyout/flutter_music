import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/widget/appbar/my_appbar.dart';

class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  void initState() {
    context.read<SetViewModel>().initViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClickEffectWidget(
      child: Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                ListTile(
                  title: Text("日/夜间模式"),
                  onTap: () => context.read<SetViewModel>().setThemeMode(),
                  trailing: SizedBox(
                    width: 80.w,
                    child: FlareActor(
                      "assets/switch_daytime.flr",
                      animation: context.watch<SetViewModel>().status,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("头像"),
                  onTap: () => context.read<SetViewModel>().setAvatar(),
                  trailing: SizedBox(
                    child: context.watch<SetViewModel>().croppedFile != null
                        ? Image.file(context.watch<SetViewModel>().croppedFile!)
                        : Icon(Icons.add_circle_outlined, size: 30.w),
                  ),
                ),
                // SwitchListTile(
                //   title: Text("边听边存"),
                //   value: context.watch<SetViewModel>().listenCache,
                //   onChanged: (v) => context.read<SetViewModel>().setListenAndSave(),
                // ),
                SwitchListTile(
                  title: Text("开启足迹效果"),
                  value: context.watch<SetViewModel>().openPaw,
                  onChanged: (v) => context.read<SetViewModel>().setPaw(),
                ),
                if (context.watch<SetViewModel>().openPaw)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 2.w,
                      runSpacing: 2.w,
                      children: [
                        ...List.generate(context.watch<SetViewModel>().footprints.length, (index) {
                          return InkWell(
                            onTap: context.read<SetViewModel>().footprints[index].isSelect
                                ? null
                                : () => context.read<SetViewModel>().selectFootprint(index),
                            child: Container(
                              color: context.read<SetViewModel>().footprints[index].isSelect
                                  ? Colors.grey.withOpacity(0.2)
                                  : null,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    context.watch<SetViewModel>().footprints[index].assetImage,
                                    width: 50.w,
                                    height: 50.w,
                                    fit: BoxFit.contain,
                                  ),
                                  if (context.watch<SetViewModel>().footprints[index].isSelect)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Icon(Icons.check_circle_outline_rounded, size: 20.w),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
