import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportUserInfoLoading extends ReportState {}

class ReportUserInfoLoaded extends ReportState {
  final ReportedUserInfoEntity userInfo;

  const ReportUserInfoLoaded({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}

class ReportSubmitting extends ReportState {
  final ReportedUserInfoEntity userInfo;

  const ReportSubmitting({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}

class ReportSubmitted extends ReportState {}

class ReportError extends ReportState {
  final String message;

  const ReportError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReportSubmitError extends ReportState {
  final String message;
  final ReportedUserInfoEntity userInfo;

  const ReportSubmitError({required this.message, required this.userInfo});

  @override
  List<Object?> get props => [message, userInfo];
}
