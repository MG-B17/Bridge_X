import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/feature/report/data/datasource/report_remote_data_source.dart';
import 'package:bridge_x/feature/report/data/models/submit_report_request_model.dart';
import 'package:bridge_x/feature/report/domain/entities/report_entity.dart';
import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:bridge_x/feature/report/domain/repositories/report_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReportRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ReportedUserInfoEntity>> getUserReportInfo(int userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getUserReportInfo(userId);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server error'));
      } on DioException catch (e) {
        return Left(ErrorHandler.handle(e));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReportEntity>> submitReport(SubmitReportRequestModel request) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.submitReport(request);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server error'));
      } on DioException catch (e) {
        return Left(ErrorHandler.handle(e));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
