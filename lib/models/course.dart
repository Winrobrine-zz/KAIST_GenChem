class Course {
  bool isEnabled;
  String courseTitle;
  String courseNo;
  String syllabus;
  String lectureNotes;
  String expProcedure;
  String taContact;
  String quizSchedule;
  String practiceSchedule;
  String examInfo;
  String notice;
  String pastPapers;
  String labSafety;

  Course.fromMap(Map<String, dynamic> map) {
    isEnabled = map["isEnabled"];
    courseTitle = map["courseTitle"];
    courseNo = map["courseNo"];
    syllabus = map["syllabus"];
    lectureNotes = map["lectureNotes"];
    expProcedure = map["expProcedure"];
    taContact = map["taContact"];
    quizSchedule = map["quizSchedule"];
    practiceSchedule = map["practiceSchedule"];
    examInfo = map["examInfo"];
    notice = map["notice"];
    pastPapers = map["pastPapers"];
    labSafety = map["labSafety"];
  }

  Map<String, dynamic> toMap() => {
        "isEnabled": isEnabled,
        "courseTitle": courseTitle,
        "courseNo": courseNo,
        "syllabus": syllabus,
        "lectureNotes": lectureNotes,
        "expProcedure": expProcedure,
        "taContact": taContact,
        "quizSchedule": quizSchedule,
        "practiceSchedule": practiceSchedule,
        "examInfo": examInfo,
        "notice": notice,
        "pastPapers": pastPapers,
        "labSafety": labSafety,
      };
}
