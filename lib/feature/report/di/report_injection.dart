import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/feature/report/data/datasource/report_remote_data_source.dart';
import 'package:bridge_x/feature/report/data/repositories/report_repository_impl.dart';
import 'package:bridge_x/feature/report/domain/repositories/report_repository.dart';
import 'package:bridge_x/feature/report/domain/usecases/get_user_report_info_usecase.dart';
import 'package:bridge_x/feature/report/domain/usecases/submit_report_usecase.dart';
import 'package:bridge_x/feature/report/presentation/controller/report_cubit.dart';

void initReport() {
  sl.registerLazySingleton<ReportRemoteDataSource>(
    () => ReportRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<GetUserReportInfoUseCase>(
    () => GetUserReportInfoUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SubmitReportUseCase>(
    () => SubmitReportUseCase(repository: sl()),
  );

  sl.registerFactory<ReportCubit>(
    () => ReportCubit(getUserReportInfoUseCase: sl(), submitReportUseCase: sl()),
  );
}
