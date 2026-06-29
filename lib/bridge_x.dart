import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/features/auth/presentation/controller/account/account_cubit.dart';
import 'package:bridge_x/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/di.dart' as di;
import 'core/navigation/bridge_x_routes.dart';
import 'core/theme/bridge_x_theme.dart';
import 'core/theme/theme_controller.dart';

class BridgeXApp extends StatelessWidget {
  const BridgeXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>(),
        ),
        BlocProvider(create: (_) => di.sl<AccountCubit>()),
        BlocProvider(create: (_) => di.sl<ScrollCubit>()),
        BlocProvider(
          create: (_) => di.sl<NotificationsCubit>()..fetchUnreadCount(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_,_) => MaterialApp.router(
              title: AppStrings.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              routerConfig: appRouter,
            ),
          );
        },
      ),
    );
  }
}
