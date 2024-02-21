abstract class AttendStates {}

class InitialAttendState extends AttendStates {}

class ChangeLectureFlagAttendState extends AttendStates {}

class ChangeShowContainerAttendState extends AttendStates {}

class CreateAttendLoadingAttendState extends AttendStates {}

class CreateAttendSuccessAttendState extends AttendStates {}

class CreateAttendErrorAttendState extends AttendStates {
  late String error;

  CreateAttendErrorAttendState(this.error);
}

class UpdateAttendLoadingAttendState extends AttendStates {}

class UpdateAttendSuccessAttendState extends AttendStates {
  late String name;

  UpdateAttendSuccessAttendState(this.name);
}

class UpdateAttendErrorAttendState extends AttendStates {
  late String error;

  UpdateAttendErrorAttendState(this.error);
}

class GetAllUsersLoadingAttendState extends AttendStates {}

class GetAllUsersSuccessAttendState extends AttendStates {
  late Map<String, Map<String, int>?> attendTeamID;

  GetAllUsersSuccessAttendState(this.attendTeamID);
}

class GetAllUsersErrorAttendState extends AttendStates {
  late String error;

  GetAllUsersErrorAttendState(this.error);
}

class LogOutSuccessAttendState extends AttendStates {}

class GetUserLoadingAttendState extends AttendStates {}

class GetUserSuccessAttendState extends AttendStates {}

class GetUserErrorAttendState extends AttendStates {
  late String error;

  GetUserErrorAttendState(this.error);
}
