import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machine_test/src/features/login/data/models/repo_response.dart';
import 'package:machine_test/src/services/headers.dart';
import 'package:machine_test/src/services/http_services.dart';

///Implementation of service methods
class HttpServiceRequests implements HttpService {
  @override
  Future<ApiResponse> post(
    String uri,
    Map<String, dynamic> jsonPayload,
  ) async {
    try {
      final url = Uri.parse(uri);
      final response = await http.post(url, body: jsonPayload, headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return ApiResponse.success(responseBody);
      } else {
        return ApiResponse.error("Something went wrong ");
      }
    } catch (e) {
      return ApiResponse.error("Something went wrong\n$e");
    }
  }
}
