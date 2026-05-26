import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import 'package:bridge_x/feature/report/data/models/reported_user_info_response_model.dart';
import 'package:bridge_x/feature/report/data/models/submit_report_request_model.dart';
import 'package:bridge_x/feature/report/data/models/submit_report_response_model.dart';
import 'package:dio/dio.dart';

abstract class ReportRemoteDataSource {
  Future<ReportedUserInfoResponseModel> getUserReportInfo(int userId);
  Future<SubmitReportResponseModel> submitReport(SubmitReportRequestModel request);
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final ApiClient apiClient;

  ReportRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ReportedUserInfoResponseModel> getUserReportInfo(int userId) async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.reportInfo(userId: userId));
      if (response.data != null) {
        return ReportedUserInfoResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubmitReportResponseModel> submitReport(SubmitReportRequestModel request) async {
    try {
      final response = await apiClient.post(path: ApiEndpoint.reports, data: request.toJson());
      if (response.data != null) {
        return SubmitReportResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Empty response data received');
      }
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
