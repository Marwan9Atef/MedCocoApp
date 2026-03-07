import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valo/feature/auth/data/models/register_request_model.dart';
import 'package:valo/feature/auth/domain/auth_repo.dart';
import 'package:valo/feature/auth/presentation/cubit/register/register_states.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  final AuthRepo authRepo;
  RegisterCubit({required this.authRepo}) : super(RegisterInitial());

  void register(RegisterRequestModel registerRequestModel) async {
    emit(RegisterLoading());
    final result = await authRepo.register(registerRequestModel);
    result.fold(
      (failure) => emit(RegisterFailure(error: failure.message)),
      (success) => emit(RegisterSuccess(message: success.message!)),
    );
  }
}
