package com.moyou.flutter_music;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;

import androidx.annotation.NonNull;

import com.moyou.flutter_music.flutter_method_channel.FlutterMethodChannel;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        super.configureFlutterEngine(flutterEngine);
//        getPermission(flutterEngine);
        FlutterMethodChannel flutterMethodChannel = new FlutterMethodChannel();
        flutterMethodChannel.backToDesktop(flutterEngine,this);
    }

//    private void backToDesktop(FlutterEngine flutterEngine) {
//        String channelName = "backToDesktopChannelName";
//        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), channelName);
//        methodChannel.setMethodCallHandler((methodCall, result) -> {
//            if (methodCall.method.equals("backToDesktop")) {
//                try {
//                    Intent home = new Intent(Intent.ACTION_MAIN);
//                    home.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                    home.addCategory(Intent.CATEGORY_HOME);
//                    startActivity(home);
//                    result.success(true);
//                } catch (Error error) {
//                    result.success(false);
//                }
//            }
//        });
//    }


//    //获取权限
//    private void getPermission(FlutterEngine flutterEngine) {
//        String name = "android/permission";
//        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), name);
//        methodChannel.setMethodCallHandler((methodCall, result) -> {
////            String apkPath = methodCall.argument("apkPath");
////            System.out.println(apkPath);
//
//            if (methodCall.method.equals("checkPermission")) {
////                System.out.println(Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q);
////                System.out.println(Environment.getExternalStorageDirectory());
//
//                Intent intent = new Intent();
//                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
////                    System.out.println(Environment.isExternalStorageLegacy());
//
//                    //Environment.isExternalStorageManager()
//                    if (!Environment.isExternalStorageLegacy()) {
//                        intent.setAction(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES);
//                        intent.setData(Uri.parse("package:" + getPackageName()));
//                        startActivityForResult(intent, 1024);
//                    } else {
//                        result.success(true);
//                    }
//                } else {
//                    result.success(true);
//                }
//            }
//        });
//    }

}
