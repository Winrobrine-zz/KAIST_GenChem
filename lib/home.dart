import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/course_list_page.dart';
import 'package:gencheminkaist/pages/more_page.dart';
import 'package:gencheminkaist/pages/notice_page.dart';
import 'package:gencheminkaist/widgets/genchem.dart';
import 'package:gencheminkaist/widgets/group_box.dart';
import 'package:url_launcher/url_launcher.dart';

class GenChemHome extends StatefulWidget {
  GenChemHome({Key key}) : super(key: key);

  @override
  _GenChemHomeState createState() => _GenChemHomeState();
}

class _GenChemHomeState extends State<GenChemHome> {
  int _currentIndex = 0;
  String _genchemUrl;

  final _pages = <Widget>[
    CourseListPage(),
    NoticePage(),
    MorePage(),
  ];

  final _pageTitles = const <Text>[
    Text("Course List"),
    Text("Notice"),
    Text("More"),
  ];

  @override
  Widget build(BuildContext context) {
    final genchem = GenChem.of(context);
    final primaryColor = genchem.theme.primaryColor;

    if (_genchemUrl == null) _genchemUrl = genchem.genchemUrl;

    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(primaryColor),
      body: GroupBox(
        title: _pageTitles[_currentIndex],
        children: <Widget>[
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("KAIST GenChem"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.open_in_browser),
          onPressed: () => launch(_genchemUrl),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(Color selectedColor) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: selectedColor,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.assignment),
          title: _pageTitles[0],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.notifications),
          title: _pageTitles[1],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.more),
          title: _pageTitles[2],
        ),
      ],
    );
  }
}
