class LogoutResponseModel {
  final bool success;
  final String message;
  final int status;
  final List<dynamic> data;

  LogoutResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      data: json['data'] ?? [],
    );
  }
}
