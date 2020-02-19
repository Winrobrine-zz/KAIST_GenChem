import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/models/notice_list.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class NoticeModel extends ChangeNotifier {
  String _noticeUrl;

  NoticeList _notices;
  NoticeList get notices => _notices ?? NoticeList.empty();

  NoticeModel(String noticeUrl) : _noticeUrl = noticeUrl {
    updateNotices();
  }

  Future<void> updateNotices() async {
    try {
      final response = await Dio().get(_noticeUrl);
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
          title = title.substring(title.indexOf("[CH"), title.length - 1);

          if (result.genchemLab != null) {
            result.genchemLab.add(title.replaceAll("•", "").trimLeft());
          } else {
            result.genchem.add(title.replaceAll("•", "").trimLeft());
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
