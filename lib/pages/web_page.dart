import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPage extends StatelessWidget {
  final Widget title;
  final String url;

  WebPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: title,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () => launch(url),
          ),
        ],
      ),
      appCacheEnabled: false,
      clearCache: true,
      clearCookies: true,
      withLocalStorage: false,
      withLocalUrl: false,
      withZoom: true,
      allowFileURLs: true,
      supportMultipleWindows: true,
    );
  }
}
