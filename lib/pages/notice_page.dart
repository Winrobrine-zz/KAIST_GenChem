import 'package:flutter/material.dart';
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
                title: const Text(GENCHEM),
                children: noticeModel.notices[GENCHEM]
                    .map((title) => GenChemTile.toWebView(
                          context: context,
                          title: Text(title),
                          webTitle: const Text("Notice"),
                          url: courses
                              .firstWhere(
                                  (course) => title.contains(course.courseNo))
                              .notice,
                        ))
                    .toList(),
              ),
              GroupBox(
                title: const Text(GENCHEMLAB),
                children: noticeModel.notices[GENCHEMLAB]
                    .map((title) => GenChemTile.toWebView(
                        context: context,
                        title: Text(title),
                        webTitle: const Text("Notice"),
                        url: courses
                            .firstWhere(
                                (course) => title.contains(course.courseNo))
                            .notice))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
