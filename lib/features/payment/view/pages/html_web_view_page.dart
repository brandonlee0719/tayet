import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../helpers/config_reader.dart';

class HTMLWebViewPage extends StatefulWidget {
  final String html;
  final VoidCallback? onOTPSuccess;
  const HTMLWebViewPage({
    Key? key,
    required this.html,
    this.onOTPSuccess,
  }) : super(key: key);

  @override
  State<HTMLWebViewPage> createState() => _HTMLWebViewPageState();
}

class _HTMLWebViewPageState extends State<HTMLWebViewPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(url: await webViewController?.getUrl()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildWebView(),
            if (progress < 1.0) LinearProgressIndicator(value: progress),
          ],
        ),
      ),
    );
  }

  Widget buildWebView() {
    return InAppWebView(
      key: webViewKey,
      initialData: InAppWebViewInitialData(data: widget.html),
      initialOptions: options,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
          resources: resources,
          action: PermissionRequestResponseAction.GRANT,
        );
      },
      onLoadStart: (controller, uri) {
        if (uri.toString() == ConfigReader.redirectUrlAfterSuccessOTP) {
          if (widget.onOTPSuccess != null) {
            widget.onOTPSuccess!();
          }
          Get.back();
        }
      },
      onLoadStop: (controller, url) async {
        pullToRefreshController.endRefreshing();
      },
      onLoadError: (webController, url, code, message) {
        pullToRefreshController.endRefreshing();
        log(message + ' code' + code.toString());
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          pullToRefreshController.endRefreshing();
        }
        setState(() {
          this.progress = progress / 100;
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        log(consoleMessage.message);
      },
    );
  }
}
