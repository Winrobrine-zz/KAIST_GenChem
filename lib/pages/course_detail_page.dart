import 'package:flutter/material.dart';
import 'package:gencheminkaist/models/course.dart';
import 'package:gencheminkaist/widgets/genchem_tile.dart';
import 'package:gencheminkaist/widgets/group_box.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  CourseDetailPage({Key key, @required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.courseTitle),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        GroupBox(
          title: const Text("Notice"),
          children: <Widget>[
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.notifications),
              title: "Notice",
              webTitle: "[${course.courseNo}] Notice",
              url: course.notice,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.notifications),
              title: "Exam Notice",
              webTitle: "[${course.courseNo}] Exam Notice",
              url: course.examInfo,
            ),
          ],
        ),
        GroupBox(
          title: const Text("Reference"),
          children: <Widget>[
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: "Syllabus",
              webTitle: "[${course.courseNo}] Syllabus",
              url: course.syllabus,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: "Lecture Notes",
              webTitle: "[${course.courseNo}] Lecture Notes",
              url: course.lectureNotes,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: "Exp. Procedure",
              webTitle: "[${course.courseNo}] Exp. Procedure",
              url: course.expProcedure,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: "Past Papers",
              webTitle: "[${course.courseNo}] Past Papers",
              url: course.pastPapers,
            ),
          ],
        ),
        GroupBox(
          title: const Text("Session Schedule"),
          children: <Widget>[
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.calendar_today),
              title: "Quiz Session",
              webTitle: "[${course.courseNo}] Quiz Session",
              url: course.quizSchedule,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.calendar_today),
              title: "Practice Session",
              webTitle: "[${course.courseNo}] Practice Session",
              url: course.practiceSchedule,
            ),
          ],
        ),
        GroupBox(
          title: const Text("General Info"),
          children: <Widget>[
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.info),
              title: "TA Contact",
              webTitle: "[${course.courseNo}] TA Contact",
              url: course.taContact,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.info),
              title: "Lab Safety",
              webTitle: "[${course.courseNo}] Lab Safety",
              url: course.labSafety,
            ),
          ],
        ),
      ],
    );
  }
}
