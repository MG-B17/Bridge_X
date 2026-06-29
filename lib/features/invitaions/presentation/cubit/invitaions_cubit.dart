import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/utils/models/user_data_model.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/accept_invitation_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/decline_invitation_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_invitation_details_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_invitaions_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_join_request_details_usecase.dart';
import 'package:bridge_x/features/invitaions/domain/usecases/get_join_requests_usecase.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitaionsCubit extends Cubit<InvitaionsState> {
  final GetInvitaionsUseCase getInvitaionsUseCase;
  final GetJoinRequestsUseCase getJoinRequestsUseCase;
  final GetInvitationDetailsUseCase getInvitationDetailsUseCase;
  final GetJoinRequestDetailsUseCase getJoinRequestDetailsUseCase;
  final AcceptInvitationUseCase acceptInvitationUseCase;
  final DeclineInvitationUseCase declineInvitationUseCase;
  final InvitaionsRepository repository;
  final ChatRepository chatRepository;

  InvitaionsCubit({
    required this.getInvitaionsUseCase,
    required this.getJoinRequestsUseCase,
    required this.getInvitationDetailsUseCase,
    required this.getJoinRequestDetailsUseCase,
    required this.acceptInvitationUseCase,
    required this.declineInvitationUseCase,
    required this.repository,
    required this.chatRepository,
  }) : super(InvitaionsInitial());

  Future<void> fetchInvitations() async {
    if (state is InvitaionsLoading) return;
    emit(InvitaionsLoading());

    final invitationsResult = await getInvitaionsUseCase();
    final joinRequestsResult = await getJoinRequestsUseCase();

    if (isClosed) return;

    invitationsResult.fold(
      (failure) => emit(InvitaionsError(message: failure.message)),
      (invitations) {
        final mappedInvitations = invitations
            .map(ProjectInvitationEntity.fromInvitationEntity)
            .toList();

        joinRequestsResult.fold(
          (failure) => emit(InvitaionsError(message: failure.message)),
          (joinRequests) {
            emit(InvitaionsLoaded(
              invitations: mappedInvitations,
              joinRequests: joinRequests,
            ));
          },
        );
      },
    );
  }

  Future<void> refreshInvitations() async {
    await fetchInvitations();
  }

  Future<void> loadData() async {
    await fetchInvitations();
  }

  Future<void> fetchInvitationDetails(int invitationId) async {
    final current = state;
    if (current is! InvitaionsLoaded || current.isDetailsLoading) return;

    emit(
      current.copyWith(
        isDetailsLoading: true,
        clearDetailsError: true,
        clearDetailsActionError: true,
        clearDetailsActionSuccess: true,
      ),
    );

    final result = await getInvitationDetailsUseCase(invitationId: invitationId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        current.copyWith(
          isDetailsLoading: false,
          detailsError: failure.message,
          clearDetailsActionError: true,
          clearDetailsActionSuccess: true,
        ),
      ),
      (details) => emit(
        current.copyWith(
          isDetailsLoading: false,
          selectedInvitationDetails: details,
          clearDetailsError: true,
          clearDetailsActionError: true,
          clearDetailsActionSuccess: true,
        ),
      ),
    );
  }

  Future<void> fetchJoinRequestDetails(int joinRequestId) async {
    final current = state;
    if (current is! InvitaionsLoaded || current.isJoinRequestDetailsLoading) return;

    emit(current.copyWith(
      isJoinRequestDetailsLoading: true,
      clearJoinRequestDetailsError: true,
    ));

    final result = await getJoinRequestDetailsUseCase(joinRequestId: joinRequestId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(current.copyWith(
        isJoinRequestDetailsLoading: false,
        joinRequestDetailsError: failure.message,
      )),
      (details) => emit(current.copyWith(
        isJoinRequestDetailsLoading: false,
        selectedJoinRequestDetails: details,
        clearJoinRequestDetailsError: true,
      )),
    );
  }

  Future<void> refreshJoinRequestDetails() async {
    final current = state;
    if (current is! InvitaionsLoaded || current.selectedJoinRequestDetails == null) {
      return;
    }
    await fetchJoinRequestDetails(current.selectedJoinRequestDetails!.joinRequestId);
  }

  void switchTab(InvitaionsTab tab) {
    final current = state;
    if (current is InvitaionsLoaded) {
      emit(current.copyWith(activeTab: tab));
    }
  }

  void clearActionFeedback() {
    final current = state;
    if (current is InvitaionsLoaded) {
      emit(
        current.copyWith(
          clearDetailsActionError: true,
          clearDetailsActionSuccess: true,
        ),
      );
    }
  }

  Future<void> acceptInvitation(String id) async {
    final current = state;
    if (current is! InvitaionsLoaded || current.isInvitationActionLoading) {
      return;
    }

    final invitationId = int.tryParse(id);
    if (invitationId == null) {
      emit(current.copyWith(actionError: 'Invalid invitation id'));
      return;
    }

    emit(
      current.copyWith(
        isInvitationActionLoading: true,
        clearDetailsActionError: true,
        clearDetailsActionSuccess: true,
      ),
    );

    final result = await acceptInvitationUseCase(invitationId: invitationId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        current.copyWith(
          isInvitationActionLoading: false,
          detailsActionError: failure.message,
          clearDetailsActionSuccess: true,
        ),
      ),
      (result) async {
        final updated = current.invitations.where((e) => e.id != id).toList();
        final teamId = result.team.id;
        final secureStorage = sl<SecureStorageService>();
        final userDataStr = await secureStorage.read(key: AppKeys.userDataKey);
        if (userDataStr != null && teamId > 0) {
          final userData = UserDataModel.userDecodedata(userEncodedData: userDataStr);
          final userId = int.tryParse(userData.userId);
          if (userId != null) {
            final roomIdResult = await chatRepository.getRoomIdByTeamId(teamId);
            roomIdResult.fold(
              (_) => LoggerService.warning('Chat room not found for team: $teamId', tag: 'InvitaionsCubit'),
              (roomId) async {
                if (roomId != null) {
                  final addResult = await chatRepository.addMemberToChatRoom(roomId, userId, username: userData.userName);
                  addResult.fold(
                    (failure) => LoggerService.warning('Failed to add member to chat room: ${failure.message}', tag: 'InvitaionsCubit'),
                    (_) => LoggerService.debug('User added to chat room: $roomId', tag: 'InvitaionsCubit'),
                  );
                }
              },
            );
          }
        }
        emit(
          current.copyWith(
            invitations: updated,
            isInvitationActionLoading: false,
            detailsActionSuccessMessage: 'Invitation accepted successfully',
            clearDetailsActionError: true,
            clearDetails: true,
          ),
        );
      },
    );
  }

  Future<void> declineInvitation(String id) async {
    final current = state;
    if (current is! InvitaionsLoaded || current.isInvitationActionLoading) {
      return;
    }

    final invitationId = int.tryParse(id);
    if (invitationId == null) {
      emit(current.copyWith(actionError: 'Invalid invitation id'));
      return;
    }

    emit(
      current.copyWith(
        isInvitationActionLoading: true,
        clearDetailsActionError: true,
        clearDetailsActionSuccess: true,
      ),
    );

    final result = await declineInvitationUseCase(invitationId: invitationId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        current.copyWith(
          isInvitationActionLoading: false,
          detailsActionError: failure.message,
          clearDetailsActionSuccess: true,
        ),
      ),
      (_) {
        final updated = current.invitations.where((e) => e.id != id).toList();
        emit(
          current.copyWith(
            invitations: updated,
            isInvitationActionLoading: false,
            detailsActionSuccessMessage: 'Invitation declined successfully',
            clearDetailsActionError: true,
            clearDetails: true,
          ),
        );
      },
    );
  }

  Future<void> acceptJoinRequest(String id) async {
    final current = state;
    if (current is! InvitaionsLoaded) return;

    final result = await repository.acceptJoinRequest(id);
    if (isClosed) return;

    result.fold(
      (failure) => emit(current.copyWith(actionError: failure.message)),
      (entity) async {
        final updated = current.joinRequests.where((e) => e.id != id).toList();
        if (entity != null && entity.teamId > 0) {
          final secureStorage = sl<SecureStorageService>();
          final userDataStr = await secureStorage.read(key: AppKeys.userDataKey);
          if (userDataStr != null) {
            final userData = UserDataModel.userDecodedata(userEncodedData: userDataStr);
            final userId = int.tryParse(userData.userId);
            if (userId != null) {
              final roomIdResult = await chatRepository.getRoomIdByTeamId(entity.teamId);
              roomIdResult.fold(
                (_) => LoggerService.warning('Chat room not found for team: ${entity.teamId}', tag: 'InvitaionsCubit'),
                (roomId) async {
                  if (roomId != null) {
                    final addResult = await chatRepository.addMemberToChatRoom(roomId, userId, username: userData.userName);
                    addResult.fold(
                      (failure) => LoggerService.warning('Failed to add member to chat room: ${failure.message}', tag: 'InvitaionsCubit'),
                      (_) => LoggerService.debug('User added to chat room: $roomId', tag: 'InvitaionsCubit'),
                    );
                  }
                },
              );
            }
          }
        }
        emit(current.copyWith(joinRequests: updated, clearError: true));
      },
    );
  }

  Future<void> declineJoinRequest(String id) async {
    final current = state;
    if (current is! InvitaionsLoaded) return;

    final result = await repository.declineJoinRequest(id);
    if (isClosed) return;

    result.fold(
      (failure) => emit(current.copyWith(actionError: failure.message)),
      (_) {
        final updated = current.joinRequests.where((e) => e.id != id).toList();
        emit(current.copyWith(joinRequests: updated, clearError: true));
      },
    );
  }
}
