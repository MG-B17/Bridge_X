class EvaluateAllResponseModel {
  final bool success;
  final String message;
  final List<String> errors;
  final int totalSubmitted;
  final int totalRequested;

  const EvaluateAllResponseModel({
    required this.success,
    required this.message,
    required this.errors,
    required this.totalSubmitted,
    required this.totalRequested,
  });

  factory EvaluateAllResponseModel.fromJson(Map<String, dynamic> json) {
    return EvaluateAllResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      errors: (json['errors'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      totalSubmitted: json['total_submitted'] as int? ?? 0,
      totalRequested: json['total_requested'] as int? ?? 0,
    );
  }
}
