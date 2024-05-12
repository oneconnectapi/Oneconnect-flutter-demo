class SimpleApiResponse {
  final int statusCode;

  SimpleApiResponse(this.statusCode);

  factory SimpleApiResponse.fromJson(Map<String, dynamic> json) {
    return SimpleApiResponse(
      json['statusCode'] ?? 401,
    );
  }
}
