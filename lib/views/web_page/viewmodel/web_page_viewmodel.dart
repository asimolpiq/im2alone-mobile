import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../web_page_view.dart';

abstract class WebPageViewmodel extends State<WebPageView> {
  bool isLoading = true;
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (progress == 100 && isLoading && mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
}
