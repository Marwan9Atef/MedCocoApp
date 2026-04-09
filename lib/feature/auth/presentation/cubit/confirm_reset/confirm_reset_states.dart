abstract class ConfirmResetStates {}
class ConfirmResetInitial extends ConfirmResetStates {}
class ConfirmResetLoading extends ConfirmResetStates {}
class ConfirmResetSuccess extends ConfirmResetStates {
  final String message;
  ConfirmResetSuccess({required this.message});
}
class ConfirmResetFailure extends ConfirmResetStates {
  final String error;
  ConfirmResetFailure({required this.error});
}
