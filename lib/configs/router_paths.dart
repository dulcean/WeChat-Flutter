import 'package:WeChat/configs/router_constants.dart';
import 'package:WeChat/presentation/pages/auth/login_page.dart';
import 'package:WeChat/presentation/pages/auth/register_page.dart';
import 'package:WeChat/presentation/pages/auth/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/splash/splash_screen.dart';

class RouterPaths {
  final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: RouterConstants.splash,
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouterConstants.welcome,
        path: '/welcome',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const WelcomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: RouterConstants.login,
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: RouterConstants.register,
        path: '/register',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const RegisterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
