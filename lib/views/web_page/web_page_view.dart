import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../product/components/appbar/custom_appbar.dart';
import 'viewmodel/web_page_viewmodel.dart';

class WebPageView extends StatefulWidget {
  final String title;
  final String url;
  const WebPageView({super.key, required this.title, required this.url});

  @override
  State<WebPageView> createState() => _WebPageViewState();
}

class _WebPageViewState extends WebPageViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.title,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
