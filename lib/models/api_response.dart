class ApiResponse {
  final String accessToken;

  ApiResponse({required this.accessToken});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      accessToken: json['access_token'],
    );
  }
}