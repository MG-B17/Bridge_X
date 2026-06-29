 import 'package:bridge_x/core/error/error_handler.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/network/network_info.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<Failure, T>> safeApiCall<T>({
    required Future<T> Function() call,
    required NetworkInfo networkInfo,
    String? debugMessage,
    String? successMessage,
    String? errorMessage,
    String tag = 'AuthRepo',
  }) async {
    if (await networkInfo.isConnected) {
      try {
        if (debugMessage != null) LoggerService.debug(debugMessage, tag: tag);
        final result = await call();
        if (successMessage != null) LoggerService.info(successMessage, tag: tag);
        return Right(result);
      } on ServerException catch (e) {
        if (errorMessage != null) LoggerService.error(errorMessage, exception: e, tag: tag);
        return Left(ServerFailure(message: e.message));
      } on DioException catch (error) {
        return left(ErrorHandler.handle(error));
      }
    } else {
      LoggerService.warning('No internet connection', tag: tag);
      return Left(NetworkFailure(message: ErrorStrings.checkYouInternetConnection));
    }
  }