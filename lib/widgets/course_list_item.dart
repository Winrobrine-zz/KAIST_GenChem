import 'package:flutter/material.dart';
import 'package:gencheminkaist/widgets/genchem.dart';

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
            SizedBox(
              width: 8.0,
              height: 64.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: GenChem.of(context).theme.secondaryColor,
                ),
              ),
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
