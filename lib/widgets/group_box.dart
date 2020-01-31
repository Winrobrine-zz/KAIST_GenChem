import 'package:flutter/material.dart';
import 'package:gencheminkaist/widgets/genchem_tile.dart';

class GroupBox extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  GroupBox({Key key, @required this.title, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Iterable<Widget>>[
        [_buildTitleBox(context)],
        children,
      ].expand((e) => e).toList(),
    );
  }

  Widget _buildTitleBox(BuildContext context) {
    try {
      bool isNotVisible =
          children.cast<GenChemTile>().every((e) => !e.isVisible);
      if (isNotVisible) return const SizedBox.shrink();
    } catch (exception) {}

    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.grey[400],
        ),
      ),
      padding: const EdgeInsets.only(left: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: DefaultTextStyle(
          style: theme.textTheme.subhead.copyWith(color: Colors.grey[600]),
          child: title,
        ),
      ),
    );
  }
}
