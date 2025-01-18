import 'package:machine_test/src/features/login/data/models/repo_response.dart';

abstract class HttpService {
  ///Netwok service requests
  Future<ApiResponse> post(
    String uri,
    Map<String, dynamic> jsonPayload,
  );
}
