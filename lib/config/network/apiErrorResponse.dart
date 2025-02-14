class ApiErrorResponse {
  final List<String> message;
  final String error;
  final int statusCode;

  ApiErrorResponse({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  // Modify fromJson to properly handle the data.
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      message: List<String>.from(json['message'] ?? []),
      error: json['error'] ?? 'Unknown Error',
      statusCode: json['statusCode'] ?? 500,
    );
  }
}
