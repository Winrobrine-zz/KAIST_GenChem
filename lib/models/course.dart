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

  Course.fromMap(Map<String, dynamic> json) {
    courseTitle = json["courseTitle"];
    courseNo = json["courseNo"];
    syllabus = json["syllabus"];
    lectureNotes = json["lectureNotes"];
    expProcedure = json["expProcedure"];
    taContact = json["taContact"];
    quizSchedule = json["quizSchedule"];
    practiceSchedule = json["practiceSchedule"];
    examInfo = json["examInfo"];
    notice = json["notice"];
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
