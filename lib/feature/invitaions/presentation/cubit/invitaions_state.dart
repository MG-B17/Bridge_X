import 'package:bridge_x/feature/invitaions/domain/entities/invitation_details_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:equatable/equatable.dart';

enum InvitaionsTab { invitations, joinRequests }

abstract class InvitaionsState extends Equatable {
  const InvitaionsState();

  @override
  List<Object?> get props => [];
}

class InvitaionsInitial extends InvitaionsState {}

class InvitaionsLoading extends InvitaionsState {}

class InvitaionsLoaded extends InvitaionsState {
  final List<ProjectInvitationEntity> invitations;
  final List<JoinRequestEntity> joinRequests;
  final InvitaionsTab activeTab;
  final String? actionError;
  final InvitationDetailsEntity? selectedInvitationDetails;
  final bool isDetailsLoading;
  final String? detailsError;
  final bool isInvitationActionLoading;
  final String? detailsActionError;
  final String? detailsActionSuccessMessage;

  const InvitaionsLoaded({
    required this.invitations,
    required this.joinRequests,
    this.activeTab = InvitaionsTab.invitations,
    this.actionError,
    this.selectedInvitationDetails,
    this.isDetailsLoading = false,
    this.detailsError,
    this.isInvitationActionLoading = false,
    this.detailsActionError,
    this.detailsActionSuccessMessage,
  });

  InvitaionsLoaded copyWith({
    List<ProjectInvitationEntity>? invitations,
    List<JoinRequestEntity>? joinRequests,
    InvitaionsTab? activeTab,
    String? actionError,
    InvitationDetailsEntity? selectedInvitationDetails,
    bool? isDetailsLoading,
    String? detailsError,
    bool? isInvitationActionLoading,
    String? detailsActionError,
    String? detailsActionSuccessMessage,
    bool clearError = false,
    bool clearDetails = false,
    bool clearDetailsError = false,
    bool clearDetailsActionError = false,
    bool clearDetailsActionSuccess = false,
  }) {
    return InvitaionsLoaded(
      invitations: invitations ?? this.invitations,
      joinRequests: joinRequests ?? this.joinRequests,
      activeTab: activeTab ?? this.activeTab,
      actionError: clearError ? null : (actionError ?? this.actionError),
      selectedInvitationDetails: clearDetails
          ? null
          : (selectedInvitationDetails ?? this.selectedInvitationDetails),
      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,
      detailsError: clearDetailsError ? null : (detailsError ?? this.detailsError),
      isInvitationActionLoading:
          isInvitationActionLoading ?? this.isInvitationActionLoading,
      detailsActionError: clearDetailsActionError
          ? null
          : (detailsActionError ?? this.detailsActionError),
      detailsActionSuccessMessage: clearDetailsActionSuccess
          ? null
          : (detailsActionSuccessMessage ?? this.detailsActionSuccessMessage),
    );
  }

  @override
  List<Object?> get props => [
        invitations,
        joinRequests,
        activeTab,
        actionError,
        selectedInvitationDetails,
        isDetailsLoading,
        detailsError,
        isInvitationActionLoading,
        detailsActionError,
        detailsActionSuccessMessage,
      ];
}

class InvitaionsError extends InvitaionsState {
  final String message;

  const InvitaionsError({required this.message});

  @override
  List<Object?> get props => [message];
}
