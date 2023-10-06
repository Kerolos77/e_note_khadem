abstract class ViewMarathonTeamStates {}

class InitialMarathonState extends ViewMarathonTeamStates {}

class GetUserLoadingMarathonState extends ViewMarathonTeamStates {}

class GetUserSuccessMarathonState extends ViewMarathonTeamStates {}

class GetUserErrorMarathonState extends ViewMarathonTeamStates {
  late String error;

  GetUserErrorMarathonState(this.error);
}

class SearchLoadingMarathonState extends ViewMarathonTeamStates {}

class SearchSuccessMarathonState extends ViewMarathonTeamStates {}

class SearchErrorMarathonState extends ViewMarathonTeamStates {
  late String error;

  SearchErrorMarathonState(this.error);
}

class SortLoadingMarathonState extends ViewMarathonTeamStates {}

class SortSuccessMarathonState extends ViewMarathonTeamStates {}

class SortErrorMarathonState extends ViewMarathonTeamStates {
  late String error;

  SortErrorMarathonState(this.error);
}

class AddCommentLoadingMarathonState extends ViewMarathonTeamStates {}

class AddCommentSuccessMarathonState extends ViewMarathonTeamStates {}

class AddCommentErrorMarathonState extends ViewMarathonTeamStates {
  late String error;

  AddCommentErrorMarathonState(this.error);
}
