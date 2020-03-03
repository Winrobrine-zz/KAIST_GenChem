import 'package:gencheminkaist/models/notice.dart';

class NoticeList {
  List<Notice> genchem;
  List<Notice> genchemLab;

  NoticeList({this.genchem, this.genchemLab});

  NoticeList.empty() : this(genchem: [], genchemLab: []);
}
