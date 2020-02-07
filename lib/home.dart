import 'package:flutter/material.dart';
import 'package:gencheminkaist/constants/color.dart';
import 'package:gencheminkaist/pages/course_list_page.dart';
import 'package:gencheminkaist/pages/more_page.dart';
import 'package:gencheminkaist/pages/notice_page.dart';
import 'package:gencheminkaist/providers/notice_model.dart';
import 'package:gencheminkaist/widgets/genchem.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GenChemHome extends StatefulWidget {
  GenChemHome({Key key}) : super(key: key);

  @override
  _GenChemHomeState createState() => _GenChemHomeState();
}

class _GenChemHomeState extends State<GenChemHome> {
  int _currentIndex = 0;
  String _genchemUrl;

  final _pageTitles = const <Text>[
    Text("Course List"),
    Text("Notice"),
    Text("More"),
  ];

  @override
  Widget build(BuildContext context) {
    final genchem = GenChem.of(context);

    if (_genchemUrl == null) _genchemUrl = genchem.genchemUrl;

    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          CourseListPage(),
          ChangeNotifierProvider(
            create: (context) => NoticeModel(genchem.noticeUrl),
            child: NoticePage(),
          ),
          MorePage(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _pageTitles[_currentIndex],
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.open_in_browser),
          onPressed: () => launch(_genchemUrl),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: PRIMARY_COLOR,
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
