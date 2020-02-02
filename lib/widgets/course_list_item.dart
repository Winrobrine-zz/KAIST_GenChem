import 'package:flutter/material.dart';
import 'package:gencheminkaist/constants/color.dart';

class CourseListItem extends StatelessWidget {
  final Widget title;
  final VoidCallback onTap;

  CourseListItem({Key key, @required this.title, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: <Widget>[
            Container(
              color: SECONDARY_COLOR,
              width: 8.0,
              height: 64.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.grey[600]),
                child: title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
