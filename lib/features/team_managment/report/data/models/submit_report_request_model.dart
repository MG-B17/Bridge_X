class SubmitReportRequestModel {
  final int targetProgrammerId;
  final String description;

  const SubmitReportRequestModel({
    required this.targetProgrammerId,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'target_programmer_id': targetProgrammerId,
        'description': description,
      };
}
