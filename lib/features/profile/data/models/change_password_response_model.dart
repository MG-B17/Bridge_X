class ChangePasswordResponseModel {
  final String message;

  const ChangePasswordResponseModel({required this.message});

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      message: json['message'] as String? ?? '',
    );
  }
}
