class UserModel {
  late String fullName;
  late String email;
  late String ID;
  late String phone;
  late String password;
  late String gender;
  late String birthDate;
  late String teamId;
  late String userType;

  UserModel(this.fullName, this.email, this.ID, this.phone, this.password,
      this.gender, this.birthDate, this.teamId, this.userType);

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    ID = json['id'];
    phone = json['phone'];
    password = json['password'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    teamId = json['teamId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'id': ID,
      'phone': phone,
      "password": password,
      "gender": gender,
      "birthDate": birthDate,
      "teamId": teamId,
      "userType": userType,
    };
  }
}
