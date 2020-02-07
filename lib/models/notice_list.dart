class NoticeList {
  List<String> genchem;
  List<String> genchemLab;

  NoticeList({this.genchem, this.genchemLab});

  NoticeList.empty() : this(genchem: [], genchemLab: []);
}
