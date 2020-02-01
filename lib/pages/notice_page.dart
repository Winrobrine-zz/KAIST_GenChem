import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/widgets/genchem.dart';
import 'package:gencheminkaist/widgets/genchem_tile.dart';
import 'package:gencheminkaist/widgets/group_box.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

const String GENCHEM = "General Chemistry";
const String GENCHEMLAB = "General Chemistry Laboratory";

class NoticePage extends StatefulWidget {
  NoticePage({Key key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  String _noticeUrl;

  @override
  Widget build(BuildContext context) {
    final genChem = GenChem.of(context);

    if (_noticeUrl == null) _noticeUrl = genChem.noticeUrl;

    return FutureBuilder<Map<String, List<String>>>(
      future: _getNotices(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              children: <Widget>[
                GroupBox(
                  title: const Text(GENCHEM),
                  children: snapshot.data[GENCHEM]
                      .map((title) => GenChemTile.toWebView(
                            context: context,
                            title: Text(title),
                            webTitle: const Text("Notice"),
                            url: genChem.courses
                                .firstWhere(
                                    (course) => title.contains(course.courseNo))
                                .notice,
                          ))
                      .toList(),
                ),
                GroupBox(
                  title: const Text(GENCHEMLAB),
                  children: snapshot.data[GENCHEMLAB]
                      .map((title) => GenChemTile.toWebView(
                          context: context,
                          title: Text(title),
                          webTitle: const Text("Notice"),
                          url: genChem.courses
                              .firstWhere(
                                  (course) => title.contains(course.courseNo))
                              .notice))
                      .toList(),
                )
              ],
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
      final response = await Dio().get(_noticeUrl);
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
