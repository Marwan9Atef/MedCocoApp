import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valo/feature/auth/domain/auth_repo.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_states.dart';

@injectable
class ForgetCubit extends Cubit<ForgetStates> {
  final AuthRepo _authRepo;
  ForgetCubit(this._authRepo) : super(ForgetInitial());

  void forget(String email) async {
    emit(ForgetLoading());
    final result = await _authRepo.forget(email);
    result.fold(
      (failure) => emit(ForgetFailure(error: failure.message)),
      (message) => emit(ForgetSuccess(message: message)),
    );
  }
}
