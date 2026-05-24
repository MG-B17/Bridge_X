import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<Response> get({required String path, Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post({required String path, required dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> put({required String path, required dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response> delete({required String path}) async {
    return await dio.delete(path);
  }
}
