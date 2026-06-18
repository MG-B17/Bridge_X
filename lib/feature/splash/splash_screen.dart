import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/init/init_app.dart';
import 'package:bridge_x/core/services/cache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/feature/splash/widgets/splash_content.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = sl<AppState>();
    _initializeAnimations();
    _initApp();
  }

  static const Duration _minSplashDuration = Duration(milliseconds: 2500);

  void _initApp() async {
    try {
      await Future.wait([_loadAppData(), Future.delayed(_minSplashDuration)]);
      _markAppReady();
    } catch (e) {
      _markAppReady();
    }
  }

  Future<void> _loadAppData() async {
    final result = await sl<AppInitializer>().init();

    _appState.isLoggedIn = result.isLoggedIn;
    _appState.hasSeenOnboarding = result.hasSeenOnboarding;
    _appState.isVerified = result.isVerified;
    _appState.trackSelectionCompleted = result.trackSelectionCompleted;
    _appState.isProfileComplete = result.isProfileComplete;
    _appState.username = result.username;

    if (result.isLoggedIn && !result.isVerified) {
      final secureStorage = sl<SecureStorageService>();
      await secureStorage.delete(key: AppKeys.authToken);
      await secureStorage.delete(key: AppKeys.userId);
      await secureStorage.delete(key: AppKeys.userName);
      await secureStorage.delete(key: AppKeys.isVerified);
      await secureStorage.delete(key: AppKeys.trackSelectionCompleted);
      await secureStorage.delete(key: AppKeys.isProfileComplete);
      await sl<CacheService>().clearData();
      _appState.isLoggedIn = false;
      _appState.isVerified = false;
      _appState.trackSelectionCompleted = false;
      _appState.isProfileComplete = false;
      _appState.username = null;
    }
  }

  void _markAppReady() {
    if (mounted) {
      sl<AppState>().isReady = true;
    }
  }

  void _initializeAnimations() {
    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashContent(fadeAnimation: _fadeAnimation, scaleAnimation: _scaleAnimation),
      ),
    );
  }
}
