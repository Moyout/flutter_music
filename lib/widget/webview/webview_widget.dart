///
///author: DJT
///created on: 2021/9/6 20:49
///
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_music/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String title;
  final String url;

  const WebViewWidget({
    Key? key,
    this.title = "",
    this.url = "https://www.baidu.com",
  }) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebViewController webC;
  late RefreshController reC;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    reC = RefreshController();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool canGoBack = await webC.canGoBack();
        if (canGoBack) webC.goBack();
        return !canGoBack;
      },
      child: Scaffold(
        appBar: MyAppBar(
          icon: Icons.close,
          title: Text(widget.title),
          actions: [MyElevatedButton(() => webC.reload(), Icons.refresh)],
          bottom: progress != 1
              ? PreferredSize(
                  child: LinearProgressIndicator(value: progress),
                  preferredSize: Size(MediaQuery.of(context).size.width, 0),
                )
              : null,
        ),
        body: WebView(
          onWebViewCreated: (WebViewController controller) => webC = controller,
          navigationDelegate: (NavigationRequest request) {
            //对于需要拦截的操作 做判断
            if (request.url.startsWith("bilibili://")) {
              return NavigationDecision.prevent;
            }
            //不需要拦截的操作
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          onProgress: (int value) {
            setState(() {
              progress = value / 100;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print("error.description----------------->${error.description}");
            print("error.domain----------------->${error.domain}");
            print("error.errorCode----------------->${error.errorCode}");
            print("error.errorType----------------->${error.errorType}");
            print("error.errorType----------------->${error.failingUrl}");
          },
        ),
      ),
    );
  }
}
