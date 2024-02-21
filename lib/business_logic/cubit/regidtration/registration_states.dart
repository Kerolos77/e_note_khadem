abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class ChangeRegistration extends RegistrationState {}

class ChangeEnvState extends RegistrationState {}

class SignUpLoadingRegistrationState extends RegistrationState {}

class SignUpSuccessRegistrationState extends RegistrationState {}

class SignUpErrorRegistrationState extends RegistrationState {
  late String error;

  SignUpErrorRegistrationState(this.error);
}

class EmailVerificationLoadingRegistrationState extends RegistrationState {}

class EmailVerificationSuccessRegistrationState extends RegistrationState {}

class EmailVerificationErrorRegistrationState extends RegistrationState {
  late String error;

  EmailVerificationErrorRegistrationState(this.error);
}

class LoginLoadingRegistrationState extends RegistrationState {}

class LoginSuccessRegistrationState extends RegistrationState {
  late String uid;

  LoginSuccessRegistrationState(this.uid);
}

class LoginErrorRegistrationState extends RegistrationState {
  late String error;

  LoginErrorRegistrationState(this.error);
}

class LogoutLoadingRegistrationState extends RegistrationState {}

class LogoutSuccessRegistrationState extends RegistrationState {}

class LogoutErrorRegistrationState extends RegistrationState {
  late String error;

  LogoutErrorRegistrationState(this.error);
}

class UserTypeNotAllowedRegistrationState extends RegistrationState {}
