class ApiResponse {
  const ApiResponse(
      {required this.statusCode,
      required this.isSuccess,
      this.responseData,
      this.errorMessage = 'Something went wrong'});

  final int statusCode;
  final bool isSuccess;
  final dynamic responseData;
  final String? errorMessage;
}
