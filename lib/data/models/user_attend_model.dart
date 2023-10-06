class UserAttendModel {
  late String date;
  late String lecture1;
  late String lecture2;

  UserAttendModel(this.date, this.lecture1, this.lecture2);

  UserAttendModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    lecture1 = json['lecture1'];
    lecture2 = json['lecture2'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'lecture1': lecture1,
      'lecture2': lecture2,
    };
  }
}
