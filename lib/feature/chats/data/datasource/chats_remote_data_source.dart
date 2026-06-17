import 'package:dio/dio.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/error/error_strings.dart';
import 'package:bridge_x/core/network/api/api_client.dart';
import 'package:bridge_x/core/network/api/api_endpoint.dart';
import '../models/chat_room_response_model.dart';

abstract class ChatsRemoteDataSource {
  Future<List<ChatRoomResponseModel>> getMyChats();
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final ApiClient apiClient;

  ChatsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ChatRoomResponseModel>> getMyChats() async {
    try {
      final response = await apiClient.get(path: ApiEndpoint.myChats);
      final responseData = response.data;

      if (responseData is Map<String, dynamic> && responseData['data'] is List) {
        final List<dynamic> chatsJson = responseData['data'];
        return chatsJson
            .map((json) => ChatRoomResponseModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw ServerException(ErrorStrings.serverError);
      }
    }
  }
}
