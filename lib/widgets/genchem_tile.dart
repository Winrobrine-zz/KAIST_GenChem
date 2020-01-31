import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/web_page.dart';

class GenChemTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback onTap;
  final bool isVisible;

  GenChemTile(
      {Key key,
      this.leading,
      @required this.title,
      this.onTap,
      this.isVisible = true})
      : super(key: key);

  GenChemTile.toWebView(
      {Key key,
      Widget leading,
      @required Widget title,
      @required String url,
      @required BuildContext context,
      Widget webTitle})
      : this(
            key: key,
            leading: leading,
            title: title,
            isVisible: url != null && url.isNotEmpty,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WebPage(
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
          height: 64.0,
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
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subhead,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  child: title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
