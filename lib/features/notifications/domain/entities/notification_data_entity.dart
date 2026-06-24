import 'package:equatable/equatable.dart';

class NotificationDataEntity extends Equatable {
  final String? teamId;
  final String? teamName;
  final String? actionUrl;

  const NotificationDataEntity({this.teamId, this.teamName, this.actionUrl});

  @override
  List<Object?> get props => [teamId, teamName, actionUrl];
}
