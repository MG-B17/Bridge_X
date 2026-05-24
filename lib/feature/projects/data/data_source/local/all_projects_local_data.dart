import 'dart:convert';
import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/feature/projects/data/models/all_projects_response_model.dart';

abstract class AllProjectsLocalData {
  Future<AllProjectsResponseModel> getCachedProjects();
  Future<void> cacheProjects(AllProjectsResponseModel data);
  Future<void> clearCache();
}

class AllProjectsLocalDataImpl implements AllProjectsLocalData {
  final CacheService cacheService;

  AllProjectsLocalDataImpl({required this.cacheService});

  @override
  Future<AllProjectsResponseModel> getCachedProjects() async {
    try {
      final jsonString = cacheService.getData(key: AppKeys.projectsCacheKey) as String?;
      if (jsonString == null || jsonString.isEmpty) {
        throw CacheException('No cached projects found');
      }
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AllProjectsResponseModel.fromJson(json);
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException('Failed to read cached projects: $e');
    }
  }

  @override
  Future<void> cacheProjects(AllProjectsResponseModel data) async {
    try {
      final jsonString = jsonEncode(data.toJson());
      await cacheService.saveData(key: AppKeys.projectsCacheKey, value: jsonString);
    } catch (e) {
      throw CacheException('Failed to cache projects: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await cacheService.removeData(key: AppKeys.projectsCacheKey);
    } catch (e) {
      throw CacheException('Failed to clear projects cache: $e');
    }
  }
}
