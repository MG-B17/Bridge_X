import 'package:bridge_x/feature/profile/domain/entities/edit_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final EditProfileEntity profile;

  const EditProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileUpdating extends EditProfileState {
  final EditProfileEntity profile;

  const EditProfileUpdating({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileUpdated extends EditProfileState {
  final EditProfileEntity profile;

  const EditProfileUpdated({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileError extends EditProfileState {
  final String message;

  const EditProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
