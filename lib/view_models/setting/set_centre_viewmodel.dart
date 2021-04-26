import 'dart:io';

import 'package:flutter_music/common/keys/public_keys.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class SetViewModel extends ChangeNotifier {
  ImagePicker picker = ImagePicker();
  String status = "day_idle";
  bool isDark = false;
  bool listenCache = false;
  bool openPaw = false;
  File? image;
  File? croppedFile;

  ///初始化ViewModel
  void initViewModel() {
    image = null;
    croppedFile = null;
    // notifyListeners();
  }

  Future<void> appInitSetting() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      isDark = SpUtil.getBool(PublicKeys.darkTheme) ?? false;
      !isDark ? status = dayIdle : status = nightIdle;
      listenCache = SpUtil.getBool(PublicKeys.darkTheme) ?? false;
      openPaw = SpUtil.getBool(PublicKeys.openPaw) ?? false;
      notifyListeners();
    });
  }

  ///设置日/夜间模式
  Future<void> setThemeMode() async {
    if (status == dayIdle) {
      status = switchNight;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      status = nightIdle;
      isDark = true;
      notifyListeners();
      await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    } else if (status == nightIdle) {
      status = switchDay;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      status = dayIdle;
      isDark = false;
      notifyListeners();
      await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    }
  }

  ///边听边存
  Future<void> setListenAndSave() async {
    listenCache = !listenCache;
    await SpUtil.setBool(PublicKeys.listenCache, listenCache);
    notifyListeners();
  }

  ///开启小爪
  Future<void> setPaw() async {
    openPaw = !openPaw;
    await SpUtil.setBool(PublicKeys.openPaw, openPaw);
    notifyListeners();
  }

  ///设置头像
  setAvatar() {
    getImage();
  }

  ///选择图片
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      test();
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  test() async {
    croppedFile = await ImageCropper.cropImage(
      sourcePath: image!.path,
      maxHeight: 200,
      maxWidth: 375,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      // cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioY: 275, ratioX: 200),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: '裁剪图片',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
        hideBottomControls: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    notifyListeners();
  }
}
