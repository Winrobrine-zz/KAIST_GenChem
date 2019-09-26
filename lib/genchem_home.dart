import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/course_list_page.dart';
import 'package:gencheminkaist/pages/more_page.dart';
import 'package:gencheminkaist/pages/notice_page.dart';
import 'package:gencheminkaist/widgets/genchem.dart';
import 'package:gencheminkaist/widgets/group_box.dart';
import 'package:url_launcher/url_launcher.dart';

class GenChemHome extends StatefulWidget {
  final RemoteConfig remoteConfig;

  GenChemHome({Key key, @required this.remoteConfig}) : super(key: key);

  @override
  _GenChemHomeState createState() => _GenChemHomeState();
}

class _GenChemHomeState extends State<GenChemHome> {
  int _currentIndex = 0;
  String _genchemUrl;
  List _pages;
  final _pageTitles = const [
    Text("Course List"),
    Text("Notice"),
    Text("More"),
  ];

  @override
  void initState() {
    super.initState();

    _genchemUrl = widget.remoteConfig.getString("genchem_url");
    _pages = [
      CourseListPage(),
      NoticePage(
        noticeUrl: widget.remoteConfig.getString("notice_url"),
      ),
      MorePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(
        child: GroupBox(
          title: _pageTitles[_currentIndex],
          children: <Widget>[
            Expanded(
              child: _pages[_currentIndex],
            ),
          ],
        ),
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

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: GenChem.of(context).theme.primaryColor,
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
