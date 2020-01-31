import 'package:firebase_remote_config/firebase_remote_config.dart';
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
  Size _size;
  double _selectedTabMargin = 0;
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
    final primaryColor = GenChem.of(context).theme.primaryColor;

    if (_size == null) _size = MediaQuery.of(context).size;
    if (_genchemUrl == null) _genchemUrl = GenChem.of(context).genchemUrl;

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
          _buildSelectedBar(primaryColor),
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

  Widget _buildSelectedBar(Color color) {
    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      curve: Curves.easeInOut,
      color: Colors.transparent,
      duration: const Duration(milliseconds: 300),
      height: 3,
      transform: Matrix4.translationValues(_selectedTabMargin, 0, 0),
      width: _size.width,
      child: Container(
        height: 1,
        width: _size.width / 3,
        color: color,
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(Color selectedColor) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: selectedColor,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _selectedTabMargin = _size.width / 3 * index;
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
