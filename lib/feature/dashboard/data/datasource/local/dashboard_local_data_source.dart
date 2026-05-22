import 'dart:convert';
import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/error/exception.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/core/services/app_lifecycle_service.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/feature/dashboard/data/models/dashboard_local_model.dart';
import 'package:bridge_x/feature/dashboard/data/models/dashboard_response_model.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardLocalModel> getDashboard();
  Future<void> cacheDashboard(DashboardResponseModel dashboard);
  Future<void> clearCache();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final CacheService cacheService;
  final AppLifecycleService appLifecycleService;
  DashboardLocalModel? _inMemoryDashboard;

  DashboardLocalDataSourceImpl({required this.cacheService, required this.appLifecycleService}) {
    appLifecycleService.registerShutdownCallback(() async {
      await _persistCache();
    });
  }

  @override
  Future<DashboardLocalModel> getDashboard() async {
    // 1. Check in-memory cache first
    if (_inMemoryDashboard != null) {
      LoggerService.debug('Returning in-memory dashboard data', tag: 'DashboardLocalDS');
      return _inMemoryDashboard!;
    }

    // 2. Fall back to disk (CacheService / SharedPreferences)
    try {
      LoggerService.debug('No in-memory dashboard, reading from disk...', tag: 'DashboardLocalDS');
      final cachedData = cacheService.getData(key: AppKeys.dashboardCacheKey);
      if (cachedData != null && cachedData is String) {
        final Map<String, dynamic> json = jsonDecode(cachedData);
        _inMemoryDashboard = DashboardLocalModel.fromJson(json);
        return _inMemoryDashboard!;
      }
      throw CacheException('No cached dashboard found');
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> cacheDashboard(DashboardResponseModel dashboard) async {
    // Store in memory only during runtime
    try {
      LoggerService.debug('Saving dashboard data to in-memory cache', tag: 'DashboardLocalDS');
      _inMemoryDashboard = DashboardLocalModel.fromResponseModel(dashboard, DateTime.now());
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<void> _persistCache() async {
    if (_inMemoryDashboard == null) return;
    try {
      LoggerService.debug(
        'Persisting dashboard in-memory cache to disk...',
        tag: 'DashboardLocalDS',
      );
      final jsonString = jsonEncode(_inMemoryDashboard!.toJson());
      await cacheService.saveData(key: AppKeys.dashboardCacheKey, value: jsonString);
      LoggerService.info('Successfully persisted dashboard cache to disk', tag: 'DashboardLocalDS');
    } catch (e) {
      LoggerService.error(
        'Failed to persist dashboard cache',
        exception: e,
        tag: 'DashboardLocalDS',
      );
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      _inMemoryDashboard = null;
      await cacheService.removeData(key: AppKeys.dashboardCacheKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
