import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/features/invitaions/data/datasource/invitaions_mock_datasource.dart';
import 'package:bridge_x/features/invitaions/data/datasource/invitaions_remote_datasource.dart';
import 'package:bridge_x/features/invitaions/data/datasource/join_requests_remote_datasource.dart';
import 'package:bridge_x/features/invitaions/domain/entities/accept_join_request_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/accepted_invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/invitation_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/invitation_details_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_details_entity.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/domain/repositories/invitaions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InvitaionsRepositoryImpl implements InvitaionsRepository {
  final InvitaionsRemoteDataSource remoteDataSource;
  final JoinRequestsRemoteDataSource joinRequestsRemoteDataSource;
  final InvitaionsMockDataSource mockDataSource;
  final NetworkInfo networkInfo;

  InvitaionsRepositoryImpl({
    required this.remoteDataSource,
    required this.joinRequestsRemoteDataSource,
    required this.mockDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _safeRemoteCall<T>(Future<T> Function() call) async {
    if (!await networkInfo.isConnected) {
      return Left(
        NetworkFailure(message: ErrorStrings.checkYouInternetConnection),
      );
    }

    try {
      return Right(await call());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? ErrorStrings.serverError),
      );
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvitationEntity>>> getInvitations() {
    return _safeRemoteCall(() async {
      final result = await remoteDataSource.getInvitations();
      return result.map((invitation) => invitation.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, InvitationDetailsEntity>> getInvitationDetails({
    required int invitationId,
  }) {
    return _safeRemoteCall(() async {
      final result = await remoteDataSource.getInvitationDetails(
        invitationId: invitationId,
      );
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<JoinRequestEntity>>> getJoinRequests() {
    return _safeRemoteCall(() async {
      final result = await joinRequestsRemoteDataSource.getMyJoinRequests();
      return result.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, JoinRequestDetailsEntity>> getJoinRequestDetails({
    required int joinRequestId,
  }) {
    return _safeRemoteCall(() async {
      final result = await joinRequestsRemoteDataSource.getJoinRequestDetails(
        joinRequestId: joinRequestId,
      );
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, AcceptedInvitationEntity>> acceptInvitation({
    required int invitationId,
  }) {
    return _safeRemoteCall(() async {
      final result = await remoteDataSource.acceptInvitation(
        invitationId: invitationId,
      );
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> declineInvitation({required int invitationId}) {
    return _safeRemoteCall(
      () => remoteDataSource.declineInvitation(invitationId: invitationId),
    );
  }

  @override
  Future<Either<Failure, AcceptJoinRequestEntity?>> acceptJoinRequest(String requestId) async {
    return _safeRemoteCall(() async {
      final result = await joinRequestsRemoteDataSource.acceptJoinRequest(
        joinRequestId: int.parse(requestId),
      );
      return AcceptJoinRequestEntity(teamId: result.teamId);
    });
  }

  @override
  Future<Either<Failure, void>> declineJoinRequest(String requestId) async {
    return _safeRemoteCall(() async {
      await joinRequestsRemoteDataSource.declineJoinRequest(
        joinRequestId: int.parse(requestId),
      );
    });
  }
}
