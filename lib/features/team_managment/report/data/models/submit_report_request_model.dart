class SubmitReportRequestModel {
  final int targetUserId;
  final String description;

  const SubmitReportRequestModel({
    required this.targetUserId,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'target_user_id': targetUserId,
        'description': description,
      };
}
