import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/course_detail_page.dart';
import 'package:gencheminkaist/providers/genchem_model.dart';
import 'package:gencheminkaist/widgets/course_list_item.dart';
import 'package:provider/provider.dart';

class CourseListPage extends StatelessWidget {
  CourseListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genchemModel = Provider.of<GenChemModel>(context, listen: false);

    return ListView(
      children: genchemModel.courses
          .where((course) => course.isEnabled)
          .map((course) => CourseListItem(
                title: Text("${course.courseTitle} (${course.courseNo})"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CourseDetailPage(course: course),
                    ),
                  );
                },
              ))
          .toList(),
    );
  }
}
