class GeneralResponse {
  int code = 0;
  String message = '';

  GeneralResponse({required this.code, required this.message});

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}