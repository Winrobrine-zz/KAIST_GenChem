import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/models/course.dart';

class GenChem extends InheritedWidget {
  final String genchemUrl;
  final String noticeUrl;
  final List<Course> courses;

  GenChem({
    Key key,
    @required this.genchemUrl,
    @required this.noticeUrl,
    @required this.courses,
    @required Widget home,
  }) : super(key: key, child: home);

  static GenChem of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GenChem>();
  }

  @override
  bool updateShouldNotify(GenChem oldWidget) {
    return genchemUrl != oldWidget.genchemUrl ||
        noticeUrl != oldWidget.noticeUrl ||
        !listEquals(courses, oldWidget.courses);
  }
}
