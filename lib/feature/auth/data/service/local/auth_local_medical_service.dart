abstract class AuthLocalMedicalService {
  Future<void> setToken(String? accessToken, String? refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> removeUserInfo();
  Future<void> setUserId(String? userId);
  Future<String?> getUserId();
}
