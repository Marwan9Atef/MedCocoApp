abstract class LoginStates {}
class LoginInitial extends LoginStates {}
class LoginLoading extends LoginStates {}
class LoginSuccess extends LoginStates {

  final String message;
  LoginSuccess({required this.message});
}
class LoginFailure extends LoginStates {
  final String error;
  LoginFailure({required this.error});
}