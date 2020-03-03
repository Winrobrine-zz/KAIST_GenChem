import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gencheminkaist/dio_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatelessWidget {
  final String title;
  final String url;

  WebViewPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  Future<void> _openAsPdf() async {
    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();
    final file = await FlutterHtmlToPdf.convertFromHtmlContent(
        await DioProvider().get(url), directory.path, title);
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _openAsPdf,
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () => launch(url),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return InAppWebView(
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
      onDownloadStart: (controller, url) => launch(url),
    );
  }
}
