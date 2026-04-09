abstract class ForgetStates {}
class ForgetInitial extends ForgetStates {}
class ForgetLoading extends ForgetStates {}
class ForgetSuccess extends ForgetStates {
  final String message;
  ForgetSuccess({required this.message});
}
class ForgetFailure extends ForgetStates {
  final String error;
  ForgetFailure({required this.error});
}
