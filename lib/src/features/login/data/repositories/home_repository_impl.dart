import 'package:machine_test/src/features/login/data/datasources/network/network.dart';
import 'package:machine_test/src/features/login/data/models/login_request.dart';
import 'package:machine_test/src/features/login/data/models/login_response_model.dart';
import 'package:machine_test/src/features/login/data/models/repo_response.dart';
import 'package:machine_test/src/features/login/domain/repositories/auth_repository.dart';
import 'package:machine_test/src/services/http_services.dart';
import 'package:machine_test/src/services/http_services_impl.dart';

///Implemetation of Authrepository
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl() {
    _httpService = HttpServiceRequests();
  }

  late HttpService _httpService;

  @override
  Future<RepoResponse<LoginResponseModel>> onLogin(LoginRequest request) async {
    try {
      final response = await _httpService.post(
        EndPoint.login,
        request.toJson(),
      );
      if (response.isSuccess) {
        return RepoResponse<LoginResponseModel>.success(
          response: LoginResponseModel.fromJson(response.response),
        );
      } else {
        return RepoResponse<LoginResponseModel>.error(
          errorMessage: response.message,
        );
      }
    } catch (e) {
      return RepoResponse<LoginResponseModel>.error(errorMessage: e.toString());
    }
  }
}
