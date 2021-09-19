import 'dart:io';

import 'package:flutter_music/common/keys/public_keys.dart';
import 'package:flutter_music/models/other/footprint_model.dart';
import 'package:flutter_music/provider/click_effect_provider.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:flutter_music/widget/bubble/bubble_paint.dart';
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
  String assetsFootprintString = "";
  List<FootprintModel> footprints = [
    FootprintModel("assets/images/paw.png"),
    FootprintModel("assets/images/icons/click.png"),
    FootprintModel("assets/images/icons/click2.png", clickEffect: ClickEffect.waterRipple),
  ];

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
      assetsFootprintString = SpUtil.getString(PublicKeys.assetFootprintString) ?? "";
      if (assetsFootprintString.isNotEmpty) {
        AppUtils.getContext().read<ClickEffectProvider>().setAssetImage(assetImagesString: assetsFootprintString);
        for (var item in footprints) {
          if (item.assetImage == assetsFootprintString) item.isSelect = true;
        }
      }
      notifyListeners();
    });
  }

  ///设置日/夜间模式
  Future<void> setThemeMode() async {
    if (status == dayIdle) {
      status = switchNight;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      status = nightIdle;
      isDark = true;
      notifyListeners();
      await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    } else if (status == nightIdle) {
      status = switchDay;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      status = dayIdle;
      isDark = false;
      notifyListeners();
      await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    }
  }

  // ///边听边存
  // Future<void> setListenAndSave() async {
  //   listenCache = !listenCache;
  //   await SpUtil.setBool(PublicKeys.listenCache, listenCache);
  //   notifyListeners();
  // }

  ///开启小爪
  Future<void> setPaw() async {
    openPaw = !openPaw;
    await SpUtil.setBool(PublicKeys.openPaw, openPaw);
    if (openPaw) {
      assetsFootprintString = SpUtil.getString(PublicKeys.assetFootprintString) ?? "";
      debugPrint(assetsFootprintString);
      if (assetsFootprintString.isEmpty) {
        assetsFootprintString = "assets/images/paw.png";
        await SpUtil.setString(PublicKeys.assetFootprintString, assetsFootprintString);
        for (var item in footprints) {
          if (item.assetImage == assetsFootprintString) item.isSelect = true;
        }
      } else {
        AppUtils.getContext().read<ClickEffectProvider>().setAssetImage(assetImagesString: assetsFootprintString);
      }
    }
    notifyListeners();
  }

  ///设置头像
  setAvatar() {
    getImage();
  }

  ///选择图片
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      test();
    } else {
      debugPrint('No image selected.');
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
      aspectRatio: const CropAspectRatio(ratioY: 275, ratioX: 200),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: '裁剪图片',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
        hideBottomControls: false,
      ),
      iosUiSettings: const IOSUiSettings(minimumAspectRatio: 1.0),
    );
    notifyListeners();
  }

  Future<void> selectFootprint(int index) async {
    for (var item in footprints) {
      item.isSelect = false;
    }
    footprints[index].isSelect = true;
    await SpUtil.setString(PublicKeys.assetFootprintString, footprints[index].assetImage);
    AppUtils.getContext().read<ClickEffectProvider>().setAssetImage(assetImagesString: footprints[index].assetImage);
    // print(footprints.elementAt(index).isSelect=true);
    notifyListeners();
  }
}
