import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constant/loacl_constant.dart';
import '../../../../../core/error/app_exception.dart';
import 'auth_local_medical_service.dart';

@LazySingleton(as: AuthLocalMedicalService)
class AuthLocalSecureStorageService implements AuthLocalMedicalService {
  final FlutterSecureStorage _secureStorage;
  AuthLocalSecureStorageService(this._secureStorage);

  @override
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: LoaclConstant.accessTokenKey);
    } catch (exception) {
      throw const LocalException("حدث خطأ اثناء الحصول على البيانات");
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: LoaclConstant.refreshTokenKey);
    } catch (exception) {
      throw const LocalException("حدث خطأ اثناء الحصول على البيانات");
    }
  }

  @override
  Future<void> removeUserInfo() async {
    try {
      await _secureStorage.delete(key: LoaclConstant.accessTokenKey);
      await _secureStorage.delete(key: LoaclConstant.refreshTokenKey);
      await _secureStorage.delete(key: LoaclConstant.userIdKey);
    } catch (exception) {
      throw const LocalException("حدث خطأ اثناء حذف البيانات");
    }
  }

  @override
  Future<void> setToken(String? accessToken, String? refreshToken) async {
    try {
      await _secureStorage.write(
        key: LoaclConstant.accessTokenKey,
        value: accessToken,
      );
      await _secureStorage.write(
        key: LoaclConstant.refreshTokenKey,
        value: refreshToken,
      );
    } catch (exception) {
      throw const LocalException("حدث خطأ اثناء حفظ البيانات");
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    try {
      await _secureStorage.write(
        key: LoaclConstant.userIdKey,
        value: userId,
      );
    } catch (exception) {
      throw const LocalException("حدث خطأ اثناء حفظ البيانات");
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      return await _secureStorage.read(key: LoaclConstant.userIdKey);
    } catch (exception) {
      throw const LocalException("حدث خطأ اثناء الحصول على البيانات");
    }
  }
}
