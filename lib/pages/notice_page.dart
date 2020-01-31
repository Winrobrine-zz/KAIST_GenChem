import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/widgets/genchem.dart';
import 'package:gencheminkaist/widgets/genchem_tile.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

const String GENCHEM = "General Chemistry";
const String GENCHEMLAB = "General Chemistry Laboratory";

class NoticePage extends StatefulWidget {
  final String noticeUrl;

  NoticePage({Key key, @required this.noticeUrl}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<String>>>(
      future: _getNotices(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          final textTheme = Theme.of(context).textTheme;
          final genChem = GenChem.of(context);

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              children: <Iterable<Widget>>[
                [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 64.0,
                    child: Text(
                      GENCHEM,
                      style: textTheme.subhead.copyWith(
                        color: genChem.theme.secondaryColor,
                      ),
                    ),
                  ),
                ],
                snapshot.data[GENCHEM].map((title) => GenChemTile.toWebView(
                      context: context,
                      title: Text(title),
                      webTitle: const Text("Notice"),
                      url: genChem.courses
                          .firstWhere(
                              (course) => title.contains(course.courseNo))
                          .notice,
                    )),
                [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 64.0,
                    child: Text(
                      GENCHEMLAB,
                      style: textTheme.subhead.copyWith(
                        color: genChem.theme.secondaryColor,
                      ),
                    ),
                  ),
                ],
                snapshot.data[GENCHEMLAB].map(
                  (title) => GenChemTile.toWebView(
                      context: context,
                      title: Text(title),
                      webTitle: const Text("Notice"),
                      url: genChem.courses
                          .firstWhere(
                              (course) => title.contains(course.courseNo))
                          .notice),
                ),
              ].expand((e) => e).toList(),
            ),
          );
        }
        return Center(
          child: const CircularProgressIndicator(),
        );
      },
    );
  }

  Future<Map<String, List<String>>> _getNotices() async {
    try {
      final response = await Dio().get(widget.noticeUrl);
      final document = parse(response.data);
      final result = Map<String, List<String>>();

      document.querySelectorAll("tr").forEach((e) {
        String title = e
            .querySelectorAll("*")
            .where((e) => e.firstChild is dom.Text)
            .map((e) => e.firstChild
                .toString()
                .replaceAll('"', "")
                .replaceAll("\n", ""))
            .join()
            .trim();

        if (title.endsWith("more"))
          title = title.substring(0, title.length - 4).trimRight();

        while (title.endsWith("."))
          title = title.substring(0, title.length - 1).trimRight();

        while (title.contains("  ")) title = title.replaceAll("  ", " ");

        if (title.isEmpty) {
          if (result.containsKey(GENCHEM)) {
            if (result[GENCHEM].length > 0) result[GENCHEMLAB] = [];
          } else {
            result[GENCHEM] = [];
          }
        } else if (title != "•") {
          if (result.containsKey(GENCHEMLAB))
            result[GENCHEMLAB].add(title.replaceAll("•", "").trimLeft());
          else
            result[GENCHEM].add(title.replaceAll("•", "").trimLeft());
        }
      });

      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
