abstract class ViewTeamAttendStates {}

class InitialViewTeamAttendState extends ViewTeamAttendStates {}

class GetUsersSuccessViewTeamAttendState extends ViewTeamAttendStates {}

class GetUsersLoadingViewTeamAttendState extends ViewTeamAttendStates {}

class GetUserSuccessViewTeamAttendState extends ViewTeamAttendStates {}

class GetUserLoadingViewTeamAttendState extends ViewTeamAttendStates {}

class GetUserErrorViewTeamAttendState extends ViewTeamAttendStates {
  late String error;

  GetUserErrorViewTeamAttendState(this.error);
}

class GetUserAttendSuccessViewTeamAttendState extends ViewTeamAttendStates {}

class GetUserAttendLoadingViewTeamAttendState extends ViewTeamAttendStates {}

class GetUserAttendErrorViewTeamAttendState extends ViewTeamAttendStates {
  late String error;

  GetUserAttendErrorViewTeamAttendState(this.error);
}
