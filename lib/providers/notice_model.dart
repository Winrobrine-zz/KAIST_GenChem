import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

const String GENCHEM = "General Chemistry";
const String GENCHEMLAB = "General Chemistry Laboratory";

class NoticeModel extends ChangeNotifier {
  String _noticeUrl;

  Map<String, List<String>> _notices;
  Map<String, List<String>> get notices =>
      _notices ??
      {
        GENCHEM: [],
        GENCHEMLAB: [],
      };

  NoticeModel(String noticeUrl) : _noticeUrl = noticeUrl {
    updateNotices();
  }

  Future<void> updateNotices() async {
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

        title = title.substring(title.indexOf("]") + 1).trimLeft();

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

      _notices = result;
    } catch (exception) {
      print(exception);
      _notices = null;
    }

    notifyListeners();
  }
}
