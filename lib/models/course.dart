class Course {
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

  Course.fromMap(Map<String, dynamic> map) {
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
  }

  Map<String, dynamic> toMap() => {
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
      };
}
