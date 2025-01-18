import 'package:machine_test/src/features/login/data/models/login_request.dart';
import 'package:machine_test/src/features/login/data/models/login_response_model.dart';
import 'package:machine_test/src/features/login/data/models/repo_response.dart';

///Abract class for authentication
abstract class AuthRepository {
  Future<RepoResponse<LoginResponseModel>> onLogin(LoginRequest request);
}
