import 'package:bridge_x/feature/projects_management/domain/entities/details/feedback_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/impact_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/team_member_entity.dart';
import 'package:equatable/equatable.dart';

class CompletedProjectDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String status;
  final String myTrack;
  final String? githubLink;
  final List<TeamMemberEntity> teamMembers;
  final String category;
  final int durationDays;
  final String completionDate;
  final List<FeedbackEntity> feedbacks;
  final double myRating;
  final double starsPercentage;
  final List<ImpactEntity> impacts;

  const CompletedProjectDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.myTrack,
    this.githubLink,
    required this.teamMembers,
    required this.category,
    required this.durationDays,
    required this.completionDate,
    required this.feedbacks,
    required this.myRating,
    required this.starsPercentage,
    required this.impacts,
  });

  bool get hasGithubLink => githubLink != null && githubLink!.trim().isNotEmpty;

  @override
  List<Object?> get props => [
        id, title, description, status, myTrack, githubLink,
        teamMembers, category, durationDays, completionDate,
        feedbacks, myRating, starsPercentage, impacts,
      ];
}
