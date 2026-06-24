class SoftDeleteProfileResponseModel {
  final bool success;
  final String message;

  const SoftDeleteProfileResponseModel({
    required this.success,
    required this.message,
  });

  factory SoftDeleteProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return SoftDeleteProfileResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }
}
