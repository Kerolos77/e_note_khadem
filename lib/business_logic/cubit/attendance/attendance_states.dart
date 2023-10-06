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

class DeleteBarcodeLoadingAttendState extends AttendStates {}

class DeleteBarcodeSuccessAttendState extends AttendStates {}

class DeleteBarcodeErrorAttendState extends AttendStates {
  late String error;

  DeleteBarcodeErrorAttendState(this.error);
}

class LogOutSuccessAttendState extends AttendStates {}

class GetUserLoadingAttendState extends AttendStates {}

class GetUserSuccessAttendState extends AttendStates {}

class GetUserErrorAttendState extends AttendStates {
  late String error;

  GetUserErrorAttendState(this.error);
}
