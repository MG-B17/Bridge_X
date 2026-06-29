import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/error_handler.dart';
import '../error/error_strings.dart';
import '../error/exception.dart';
import '../error/failure.dart';
import '../network/network_info.dart';

mixin RepositoryMixin {
  NetworkInfo get networkInfo;

  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
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
}
