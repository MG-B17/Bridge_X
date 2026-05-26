import 'package:bridge_x/feature/view_task/domain/entities/task_entity.dart';
import 'package:bridge_x/feature/view_task/domain/entities/view_task_entity.dart';
import 'package:bridge_x/feature/view_task/domain/entities/view_task_member_entity.dart';

class ViewTaskResponseModel {
  final int teamId;
  final String teamName;
  final String projectDescription;
  final String? githubLink;
  final String myTrack;
  final String tasksView;
  final List<ViewTaskMemberEntity> _members;
  final List<TaskEntity> _tasks;

  ViewTaskResponseModel._({
    required this.teamId,
    required this.teamName,
    required this.projectDescription,
    this.githubLink,
    required this.myTrack,
    required this.tasksView,
    required List<ViewTaskMemberEntity> members,
    required List<TaskEntity> tasks,
  })  : _members = members,
        _tasks = tasks;

  factory ViewTaskResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return ViewTaskResponseModel._(
      teamId: data['team_id'] as int? ?? 0,
      teamName: data['team_name'] as String? ?? '',
      projectDescription: data['project_description'] as String? ?? '',
      githubLink: data['github_link'] as String?,
      myTrack: data['my_track'] as String? ?? '',
      tasksView: data['tasks_view'] as String? ?? 'my',
      members: (data['members'] as List? ?? []).map((e) {
        final m = e as Map<String, dynamic>;
        return ViewTaskMemberEntity(
          id: m['id'] as int? ?? 0,
          name: m['name'] as String? ?? '',
          avatarUrl: m['avatar_url'] as String?,
          track: m['track'] as String? ?? '',
          role: m['role'] as String? ?? '',
        );
      }).toList(),
      tasks: (data['tasks'] as List? ?? []).map((e) {
        final t = e as Map<String, dynamic>;
        return TaskEntity(
          id: t['id'] as int? ?? 0,
          title: t['title'] as String? ?? '',
          description: t['description'] as String? ?? '',
          status: t['status'] as String? ?? 'todo',
          dueDate: t['due_date'] as String? ?? '',
          priority: t['priority'] as int? ?? 3,
          createdAt: t['created_at'] as String? ?? '',
        );
      }).toList(),
    );
  }

  ViewTaskEntity toEntity() => ViewTaskEntity(
        teamId: teamId,
        teamName: teamName,
        projectDescription: projectDescription,
        githubLink: githubLink,
        myTrack: myTrack,
        members: _members,
        tasksView: tasksView,
        tasks: _tasks,
      );
}
