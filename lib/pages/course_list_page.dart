import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/course_detail_page.dart';
import 'package:gencheminkaist/widgets/course_list_item.dart';
import 'package:gencheminkaist/widgets/genchem.dart';

class CourseListPage extends StatelessWidget {
  CourseListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: GenChem.of(context)
          .courses
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
