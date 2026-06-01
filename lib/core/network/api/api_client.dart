import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<Response<T>> get<T>({required String path, Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>({required String path, required dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response<T>> put<T>({required String path, required dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response<T>> delete<T>({required String path}) async {
    return await dio.delete(path);
  }

  Future<Response<T>> patch<T>({required String path, dynamic data}) async {
    return await dio.patch(path, data: data);
  }
}
