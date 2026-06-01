import 'package:equatable/equatable.dart';

sealed class SubmitProjectState extends Equatable {
  const SubmitProjectState();

  @override
  List<Object?> get props => [];
}

class SubmitProjectInitial extends SubmitProjectState {
  const SubmitProjectInitial();
}

class SubmitProjectLoading extends SubmitProjectState {
  const SubmitProjectLoading();
}

class SubmitProjectSuccess extends SubmitProjectState {
  final String message;
  final String projectStatus;

  const SubmitProjectSuccess({
    required this.message,
    required this.projectStatus,
  });

  @override
  List<Object?> get props => [message, projectStatus];
}

class SubmitProjectFailure extends SubmitProjectState {
  final String message;

  const SubmitProjectFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
