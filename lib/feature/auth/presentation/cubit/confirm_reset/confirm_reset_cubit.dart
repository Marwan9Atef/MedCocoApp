import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/feature/auth/data/models/confirm_reset_password_request_model.dart';
import 'package:medcoco/feature/auth/domain/auth_repo.dart';
import 'package:medcoco/feature/auth/presentation/cubit/confirm_reset/confirm_reset_states.dart';

@injectable
class ConfirmResetCubit extends Cubit<ConfirmResetStates> {
  final AuthRepo _authRepo;
  ConfirmResetCubit(this._authRepo) : super(ConfirmResetInitial());

  void confirmResetPassword(ConfirmResetPasswordRequest request) async {
    emit(ConfirmResetLoading());
    final result = await _authRepo.confirmResetPassword(request);
    result.fold(
      (failure) => emit(ConfirmResetFailure(error: failure.message)),
      (message) => emit(ConfirmResetSuccess(message: message)),
    );
  }
}
