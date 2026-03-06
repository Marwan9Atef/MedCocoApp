import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/data/models/login_response_model.dart';

abstract class AuthRemoteMedicalService {
Future<LoginResponseModel> login(LoginRequestModel loginRequestModel);

  
}
