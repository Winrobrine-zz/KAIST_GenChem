import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/web_view_page.dart';

class GenChemTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget bottom;
  final VoidCallback onTap;
  final bool isVisible;

  GenChemTile(
      {Key key,
      this.leading,
      @required this.title,
      this.bottom,
      this.onTap,
      this.isVisible = true})
      : super(key: key);

  GenChemTile.toWebView(
      {Key key,
      Widget leading,
      Widget bottom,
      @required String title,
      @required String url,
      @required BuildContext context,
      String webTitle})
      : this(
            key: key,
            leading: leading,
            title: Text(title),
            bottom: bottom,
            isVisible: url != null && url.isNotEmpty,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                    title: webTitle ?? title,
                    url: url,
                  ),
                ),
              );
            });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return InkWell(
      onTap: onTap,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]),
          ),
          height: bottom == null ? 64.0 : 70.0,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: leading == null
                    ? const EdgeInsets.only()
                    : const EdgeInsets.only(right: 32.0),
                child: leading,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: bottom == null
                          ? Theme.of(context).textTheme.subhead
                          : Theme.of(context).textTheme.body1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      child: title,
                    ),
                    bottom == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .copyWith(color: Colors.black54),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              child: bottom,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
