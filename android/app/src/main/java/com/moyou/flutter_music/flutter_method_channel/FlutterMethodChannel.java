package com.moyou.flutter_music.flutter_method_channel;

import android.content.Context;
import android.content.Intent;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class FlutterMethodChannel {
    public void backToDesktop(FlutterEngine flutterEngine, Context context) {
        String channelName = "backToDesktopChannelName";
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), channelName);
        methodChannel.setMethodCallHandler((methodCall, result) -> {
            if (methodCall.method.equals("backToDesktop")) {
                try {
                    Intent home = new Intent(Intent.ACTION_MAIN);
                    home.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    home.addCategory(Intent.CATEGORY_HOME);
                    context.startActivity(home);
                    result.success(true);
                } catch (Error error) {
                    result.success(false);
                }
            }
        });
    }
}
