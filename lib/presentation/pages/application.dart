import 'package:WeChat/blocs/auth/profile_fill/profile_fill_bloc.dart';
import 'package:WeChat/blocs/authentication/authentication_bloc.dart';
import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/configs/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class Application extends StatelessWidget {
  const Application({
    required this.userRepository,
    required this.userProfileRepository,
    super.key,
  });

  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => userRepository,
        ),
        RepositoryProvider<UserProfileRepository>(
          create: (context) => userProfileRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileFillBloc(
              userProfileRepository: userProfileRepository,
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: RouterPaths().router,
        ),
      ),
    );
  }
}
