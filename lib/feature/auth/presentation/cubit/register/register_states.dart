abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  final String message;
  RegisterSuccess({required this.message});
}

class RegisterFailure extends RegisterStates {
  final String error;
  RegisterFailure({required this.error});
}
