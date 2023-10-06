abstract class ViewKraatTeamStates {}

class InitialViewKraatTeamState extends ViewKraatTeamStates {}

class GetUsersSuccessViewKraatTeamState extends ViewKraatTeamStates {}

class GetUsersLoadingViewKraatTeamState extends ViewKraatTeamStates {}

class GetUserSuccessViewKraatTeamState extends ViewKraatTeamStates {}

class GetUserLoadingViewKraatTeamState extends ViewKraatTeamStates {}

class GetUserErrorViewKraatTeamState extends ViewKraatTeamStates {
  late String error;

  GetUserErrorViewKraatTeamState(this.error);
}

class GetUserKraatSuccessViewKraatTeamState extends ViewKraatTeamStates {}

class GetUserKraatLoadingViewKraatTeamState extends ViewKraatTeamStates {}

class GetUserKraatErrorViewKraatTeamState extends ViewKraatTeamStates {
  late String error;

  GetUserKraatErrorViewKraatTeamState(this.error);
}
