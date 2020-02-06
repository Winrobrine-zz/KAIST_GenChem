import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPage extends StatelessWidget {
  final Widget title;
  final String url;

  WebPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () => launch(url),
          ),
        ],
      ),
      body: InAppWebView(
        initialUrl: url,
        initialOptions: InAppWebViewWidgetOptions(
          crossPlatform: InAppWebViewOptions(
            cacheEnabled: false,
            clearCache: true,
            preferredContentMode: InAppWebViewUserPreferredContentMode.DESKTOP,
            useOnDownloadStart: true,
          ),
          android: AndroidInAppWebViewOptions(
            builtInZoomControls: true,
            displayZoomControls: true,
            loadWithOverviewMode: true,
            useWideViewPort: true,
          ),
        ),
        onDownloadStart: (controller, url) {
          launch(url);
        },
      ),
    );
  }
}
