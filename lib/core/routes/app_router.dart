import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/di/service_locator.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/feature/auth/presentation/cubit/confirm_reset/confirm_reset_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/login/login_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/register/register_cubit.dart';
import 'package:valo/feature/auth/presentation/screens/forget_screen.dart';
import 'package:valo/feature/auth/presentation/screens/login_screen.dart';
import 'package:valo/view/valo_view.dart';

import '../../feature/auth/presentation/screens/register_screen.dart';
import '../../feature/auth/presentation/screens/reset_screen.dart';
import '../widget/full_screen_image.dart';

class AppRouter {
  static final routes = GoRouter(
    routes: [
      GoRoute(
     redirect: (context, state) => null,
        path: RouteCenter.login,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator<LoginCubit>(),
              child: const LoginScreen(),
              
            ),
            
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),

      GoRoute(
        path: RouteCenter.register,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator<RegisterCubit>(),
              child: const RegisterScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.forget,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => serviceLocator<ForgetCubit>(),
              child: const ForgetScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.view,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ValoView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.search,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SizedBox(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.reset,
        pageBuilder: (context, state) {
          final email = state.extra as String;
          return CustomTransitionPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => serviceLocator<ConfirmResetCubit>(),
                ),
                BlocProvider(create: (context) => serviceLocator<ForgetCubit>()),
              ],
              child: ResetScreen(email: email),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteCenter.fullScreenImage,
        pageBuilder: (context, state) {
          final String imagePath = state.extra as String;
          return CustomTransitionPage(
            child: FullScreenImageViewer(imageUrl: imagePath),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ],
  );
}
