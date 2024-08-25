import 'package:WeChat/blocs/auth/profile_fill/profile_fill_bloc.dart';
import 'package:WeChat/configs/router_constants.dart';
import 'package:WeChat/presentation/components/navigation/navigation_bar.dart';
import 'package:WeChat/presentation/pages/auth/authentication_logic.dart';
import 'package:WeChat/presentation/pages/auth/login_page.dart';
import 'package:WeChat/presentation/pages/auth/profile_fill.dart';
import 'package:WeChat/presentation/pages/auth/register_page.dart';
import 'package:WeChat/presentation/pages/auth/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

import '../blocs/auth/login/login_bloc.dart';
import '../blocs/auth/register/register_bloc.dart';
import '../presentation/pages/features/requests_page.dart';
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
        name: RouterConstants.authentication,
        path: '/auth',
        builder: (context, state) => const AuthenticationLogic(),
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
          final userRepository = RepositoryProvider.of<UserRepository>(context);
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository),
              child: const LoginPage(),
            ),
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
          final userRepository = RepositoryProvider.of<UserRepository>(context);
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider<RegisterBloc>(
              create: (context) => RegisterBloc(userRepository),
              child: const RegisterPage(),
            ),
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
        name: RouterConstants.profileFill,
        path: '/profile_fill',
        pageBuilder: (context, state) {
          final userProfileRepository =
              RepositoryProvider.of<UserProfileRepository>(context);
          final userId = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider<ProfileFillBloc>(
              create: (context) => ProfileFillBloc(
                userProfileRepository: userProfileRepository,
              ),
              child: ProfileFillPage(userId: userId),
            ),
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
        name: RouterConstants.home,
        path: '/home',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AnimatedNavigationBottomBar(),
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
        name: 'bottom_modal',
        path: '/bottom_modal',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BottomModalScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset(0.0, 0.0);
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      )
    ],
  );
}
