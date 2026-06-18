class CompleteProfileResponseModel {
  final bool success;
  final String message;

  const CompleteProfileResponseModel({
    required this.success,
    required this.message,
  });

  factory CompleteProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }
}
