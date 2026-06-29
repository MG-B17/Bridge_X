import 'package:bridge_x/features/team_managment/projects_management/data/models/details/feedback_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/data/models/details/team_member_model.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/details/completed_project_details_entity.dart';

class CompletedProjectDetailsResponseModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final String myTrack;
  final String? githubLink;
  final String? imageUrl;
  final List<TeamMemberModel> teamMembers;
  final String category;
  final int durationDays;
  final String completionDate;
  final List<FeedbackModel> feedbacks;
  final double myRating;
  final double starsPercentage;

  const CompletedProjectDetailsResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.myTrack,
    this.githubLink,
    this.imageUrl,
    required this.teamMembers,
    required this.category,
    required this.durationDays,
    required this.completionDate,
    required this.feedbacks,
    required this.myRating,
    required this.starsPercentage,
  });

  factory CompletedProjectDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final project = data['project'] as Map<String, dynamic>? ?? data;

    return CompletedProjectDetailsResponseModel(
      id: project['id'] as int? ?? 0,
      title: project['title'] as String? ?? '',
      description: project['description'] as String? ?? '',
      status: project['status'] as String? ?? '',
      myTrack: project['my_track'] as String? ?? '',
      githubLink: project['github_link'] as String?,
      imageUrl: project['image_url'] as String?,
      teamMembers: (project['team_members'] as List? ?? [])
          .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: project['category'] as String? ?? '',
      durationDays: project['duration_days'] as int? ?? 0,
      completionDate: project['completion_date'] as String? ?? '',
      feedbacks: (project['feedbacks'] as List? ?? [])
          .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      myRating: (project['my_rating'] as num?)?.toDouble() ?? 0.0,
      starsPercentage: (project['stars_percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  CompletedProjectDetailsEntity toEntity() => CompletedProjectDetailsEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        myTrack: myTrack,
        githubLink: githubLink,
        imageUrl: imageUrl,
        teamMembers: teamMembers.map((m) => m.toEntity()).toList(),
        category: category,
        durationDays: durationDays,
        completionDate: completionDate,
        feedbacks: feedbacks.map((f) => f.toEntity()).toList(),
        myRating: myRating,
        starsPercentage: starsPercentage,
      );
}
