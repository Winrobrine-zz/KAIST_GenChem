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
              title: const Text("Notice"),
              url: course.notice,
            ),
          ],
        ),
        GroupBox(
          title: const Text("Reference"),
          children: <Widget>[
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: const Text("Syllabus"),
              url: course.syllabus,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: const Text("Lecture Notes"),
              url: course.lectureNotes,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: const Text("Exp. Procedure"),
              url: course.expProcedure,
            ),
          ],
        ),
        GroupBox(
          title: const Text("Session Schedule"),
          children: <Widget>[
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.calendar_today),
              title: const Text("Quiz Session"),
              url: course.quizSchedule,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.calendar_today),
              title: const Text("Practice Session"),
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
              title: const Text("TA Contact"),
              url: course.taContact,
            ),
          ],
        ),
        GroupBox(
          title: const Text("Exam Info"),
          children: [
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.notifications),
              title: const Text("Notice"),
              url: course.examInfo,
            ),
            GenChemTile.toWebView(
              context: context,
              leading: const Icon(Icons.insert_drive_file),
              title: const Text("Past Papers"),
              url: course.pastPapers,
            ),
          ],
        ),
      ],
    );
  }
}
