import 'package:bridge_x/features/team_managment/task_management/domain/entities/create_task_entity.dart';
import 'package:bridge_x/features/team_managment/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CreateTaskState extends Equatable {
  const CreateTaskState();
  @override
  List<Object?> get props => [];
}

class CreateTaskInitial extends CreateTaskState {
  const CreateTaskInitial();
}

class CreateTaskMembersLoading extends CreateTaskState {
  const CreateTaskMembersLoading();
}

class CreateTaskReady extends CreateTaskState {
  final List<TeamMemberEntity> members;
  final int? selectedMemberId;
  final String priority;
  final List<String> tags;
  final DateTime? selectedDate;

  const CreateTaskReady({
    required this.members,
    this.selectedMemberId,
    this.priority = 'medium',
    this.tags = const [],
    this.selectedDate,
  });

  CreateTaskReady copyWith({
    List<TeamMemberEntity>? members,
    int? selectedMemberId,
    String? priority,
    List<String>? tags,
    DateTime? selectedDate,
  }) {
    return CreateTaskReady(
      members: members ?? this.members,
      selectedMemberId: selectedMemberId ?? this.selectedMemberId,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [members, selectedMemberId, priority, tags, selectedDate];
}

class CreateTaskLoading extends CreateTaskState {
  const CreateTaskLoading();
}

class CreateTaskSuccess extends CreateTaskState {
  final CreateTaskEntity task;
  const CreateTaskSuccess(this.task);
  @override
  List<Object?> get props => [task];
}

class CreateTaskError extends CreateTaskState {
  final String message;
  const CreateTaskError(this.message);
  @override
  List<Object?> get props => [message];
}
