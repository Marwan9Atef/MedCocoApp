import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/feature/auth/data/service/local/auth_local_medical_service.dart';
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_status.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthStatus> {
  final AuthLocalMedicalService _localService;

  AuthCubit(this._localService) : super(AuthStatus.unknown);

  Future<void> checkAuth() async {
    try {
      final token = await _localService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        emit(AuthStatus.authenticated);
      } else {
        emit(AuthStatus.unauthenticated);
      }
    } catch (_) {
      emit(AuthStatus.unauthenticated);
    }
  }

  void setAuthenticated() => emit(AuthStatus.authenticated);

  Future<void> logout() async {
    await _localService.removeUserInfo();
    emit(AuthStatus.unauthenticated);
  }
}
