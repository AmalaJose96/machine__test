class ApiResponse {
  ApiResponse.success(this.response) {
    isSuccess = true;
    message = '';
  }

  ApiResponse.error(this.message) {
    isSuccess = false;
    response = {};
  }
  late bool isSuccess;
  late String message;
  late Map<String, dynamic> response;
}

class RepoResponse<T> {
  RepoResponse.success({required this.response}) {
    this.isSuccess = true;
    errorMessage = '';
  }

  RepoResponse.error({required this.errorMessage}) {
    this.isSuccess = false;
  }

  late final bool isSuccess;
  late String errorMessage;
  T? response;
}
