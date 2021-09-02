import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/view_models/setting/set_centre_viewmodel.dart';
import 'package:flutter_music/widget/appbar/my_appbar.dart';
import 'package:flutter_music/widget/button/myelevated_button.dart';

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
                  title: Text("当前模式"),
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
                  title: Text("上传头像"),
                  onTap: () => context.read<SetViewModel>().setAvatar(),
                  trailing: SizedBox(
                    child: context.watch<SetViewModel>().croppedFile != null
                        ? Image.file(context.watch<SetViewModel>().croppedFile!)
                        : Icon(Icons.add_circle_outlined,size: 30.w,),
                  ),
                ),
                SwitchListTile(
                  title: Text("边听边存"),
                  value: context.watch<SetViewModel>().listenCache,
                  onChanged: (v) => context.read<SetViewModel>().setListenAndSave(),
                ),
                SwitchListTile(
                  title: Text("开启小爪"),
                  value: context.watch<SetViewModel>().openPaw,
                  onChanged: (v) => context.read<SetViewModel>().setPaw(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
