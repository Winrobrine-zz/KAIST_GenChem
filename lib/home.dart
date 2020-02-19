import 'package:flutter/material.dart';
import 'package:gencheminkaist/constants/color.dart';
import 'package:gencheminkaist/pages/course_list_page.dart';
import 'package:gencheminkaist/pages/more_page.dart';
import 'package:gencheminkaist/pages/notice_page.dart';
import 'package:gencheminkaist/providers/genchem_model.dart';
import 'package:gencheminkaist/providers/notice_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GenChemHome extends StatefulWidget {
  GenChemHome({Key key}) : super(key: key);

  @override
  _GenChemHomeState createState() => _GenChemHomeState();
}

class _GenChemHomeState extends State<GenChemHome> {
  int _currentIndex = 0;

  final _titles = const <Text>[
    Text("Course List"),
    Text("Notice"),
    Text("More"),
  ];

  @override
  Widget build(BuildContext context) {
    final genchemModel = Provider.of<GenChemModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: _titles[_currentIndex],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () => launch(genchemModel.genchemUrl),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          CourseListPage(),
          ChangeNotifierProvider(
            create: (context) => NoticeModel(genchemModel.noticeUrl),
            child: NoticePage(),
          ),
          MorePage(),
        ],
      ),
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
          title: _titles[0],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.notifications),
          title: _titles[1],
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.more),
          title: _titles[2],
        ),
      ],
    );
  }
}
