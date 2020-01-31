import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/models/course.dart';
import 'package:gencheminkaist/models/genchem_theme.dart';

class GenChem extends InheritedWidget {
  final GenChemTheme theme;
  final List<Course> courses;

  GenChem({
    Key key,
    @required this.theme,
    @required this.courses,
    @required Widget home,
  }) : super(key: key, child: home);

  static GenChem of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GenChem>();
  }

  @override
  bool updateShouldNotify(GenChem oldWidget) {
    return theme.primaryColor != oldWidget.theme.primaryColor ||
        theme.secondaryColor != oldWidget.theme.secondaryColor ||
        !listEquals(courses, oldWidget.courses);
  }
}
