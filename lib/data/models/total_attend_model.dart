class TotalAttendModel {

  late int total;
  late int lecture1;
  late int lecture2;

  TotalAttendModel(this.total,
      this.lecture1, this.lecture2);

  TotalAttendModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lecture1 = json['lecture1'];
    lecture2 = json['lecture2'];
  }

  Map<String, dynamic> toMap() {
    return {

      'total': total,
      'lecture1': lecture1,
      'lecture2': lecture2,
    };
  }
}
