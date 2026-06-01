import 'package:bridge_x/feature/task_management/domain/entities/task_entity.dart';
import 'package:bridge_x/feature/task_management/domain/entities/view_task_member_entity.dart';
import 'package:equatable/equatable.dart';

class ViewTaskEntity extends Equatable {
  final int teamId;
  final String teamName;
  final String projectDescription;
  final String? githubLink;
  final String myTrack;
  final List<ViewTaskMemberEntity> members;
  final String tasksView;
  final List<TaskEntity> tasks;

  const ViewTaskEntity({
    required this.teamId,
    required this.teamName,
    required this.projectDescription,
    this.githubLink,
    required this.myTrack,
    required this.members,
    required this.tasksView,
    required this.tasks,
  });

  List<TaskEntity> get inProgressTasks => tasks.where((t) => t.status == 'in_progress').toList();
  List<TaskEntity> get todoTasks => tasks.where((t) => t.status == 'todo').toList();
  List<TaskEntity> get completedTasks => tasks.where((t) => t.status == 'completed').toList();

  @override
  List<Object?> get props => [teamId, teamName, projectDescription, githubLink, myTrack, members, tasksView, tasks];
}
