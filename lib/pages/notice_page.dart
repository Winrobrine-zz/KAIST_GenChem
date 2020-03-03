import 'package:flutter/material.dart';
import 'package:gencheminkaist/models/course.dart';
import 'package:gencheminkaist/models/notice.dart';
import 'package:gencheminkaist/providers/genchem_model.dart';
import 'package:gencheminkaist/providers/notice_model.dart';
import 'package:gencheminkaist/widgets/genchem_tile.dart';
import 'package:gencheminkaist/widgets/group_box.dart';
import 'package:provider/provider.dart';

class NoticePage extends StatelessWidget {
  NoticePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<GenChemModel>(context, listen: false).courses;
    final noticeModel = Provider.of<NoticeModel>(context, listen: false);

    return RefreshIndicator(
      onRefresh: noticeModel.updateNotices,
      child: Consumer<NoticeModel>(
        builder: (context, noticeModel, _) {
          return ListView(
            children: <Widget>[
              GroupBox(
                title: const Text("General Chemistry"),
                children: noticeModel.notices.genchem
                    .map((notice) => _buildTile(context, courses, notice))
                    .toList(),
              ),
              GroupBox(
                title: const Text("General Chemistry Laboratory"),
                children: noticeModel.notices.genchemLab
                    .map((notice) => _buildTile(context, courses, notice))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTile(BuildContext context, List<Course> courses, Notice notice) {
    final course =
        courses.firstWhere((course) => notice.title.contains(course.courseNo));

    return GenChemTile.toWebView(
      context: context,
      title: notice.title,
      bottom: Text(notice.date),
      webTitle: "[${course.courseNo}] Notice",
      url: course.notice,
    );
  }
}
