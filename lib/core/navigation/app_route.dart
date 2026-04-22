import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bridgex/core/helper/cache/cache_helper.dart';
import 'package:bridgex/core/di/di.dart';
import 'app_route_constant.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConstant.root,
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'), // Will be branded later
        ),
      );
    },
    redirect: (context, state) {
      final cacheHelper = sl<CacheHelper>();
      final token = cacheHelper.getToken();
      final isFirstLaunch = cacheHelper.isFirstLaunch();
      final role = cacheHelper.getUserRole();
      
      final currentPath = state.uri.path;
      final isAuthRoute = currentPath == AppRouteConstant.login ||
          currentPath == AppRouteConstant.register ||
          currentPath == AppRouteConstant.otp ||
          currentPath == AppRouteConstant.forgotPassword;

      if (currentPath == AppRouteConstant.root) {
        if (isFirstLaunch) return AppRouteConstant.onboarding;
        if (token == null) return AppRouteConstant.login;
        if (role == null) return AppRouteConstant.profileSetup;
        return AppRouteConstant.home;
      }
      
      if (currentPath == AppRouteConstant.onboarding) {
        if (!isFirstLaunch) return AppRouteConstant.login;
      }

      if (currentPath == AppRouteConstant.profileSetup) {
        if (role != null) return AppRouteConstant.home;
      }

      if (token == null && !isAuthRoute && currentPath != AppRouteConstant.onboarding) {
        return AppRouteConstant.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRouteConstant.root,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Splash Screen Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.onboarding,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Onboarding Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.login,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Login Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.register,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Register Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.otp,
        builder: (context, state) => const Scaffold(body: Center(child: Text('OTP Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.forgotPassword,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Forgot Password Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.profileSetup,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Profile Setup Stub'))),
      ),
      GoRoute(
        path: AppRouteConstant.home,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home Stub'))),
      ),
    ],
  );
}
