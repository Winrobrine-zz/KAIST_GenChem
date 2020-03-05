import 'package:flutter/material.dart';
import 'package:gencheminkaist/dio.dart';
import 'package:gencheminkaist/models/notice.dart';
import 'package:gencheminkaist/models/notice_list.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class NoticeModel extends ChangeNotifier {
  NoticeList _notices;
  NoticeList get notices => _notices ?? NoticeList.empty();

  final _noticeUrl;

  NoticeModel(String noticeUrl) : _noticeUrl = noticeUrl {
    updateNotices();
  }

  Future<void> updateNotices() async {
    try {
      final response = await dio.get(_noticeUrl);
      final document = parse(response.data);
      final result = NoticeList();

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
          if (result.genchem != null) {
            if (result.genchem.length > 0) result.genchemLab = [];
          } else {
            result.genchem = [];
          }
        } else if (title != "•") {
          title = title.replaceAll("•", "").trimLeft();

          final titleIndex = title.indexOf("[CH");
          final date = title.substring(0, titleIndex).trimRight();
          final notice = Notice(
            title: title.substring(titleIndex),
            date: date.substring(1, date.length - 1),
          );

          if (result.genchemLab != null) {
            result.genchemLab.add(notice);
          } else {
            result.genchem.add(notice);
          }
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
