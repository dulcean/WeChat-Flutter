import 'package:WeChat/blocs/auth/profile_fill/profile_fill_bloc.dart';
import 'package:WeChat/blocs/authentication/authentication_bloc.dart';
import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/configs/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../blocs/friends/find_friend/find_friend_bloc.dart';

class Application extends StatelessWidget {
  const Application({
    required this.userRepository,
    required this.userProfileRepository,
    required this.userFriendsRepository,
    super.key,
  });

  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;
  final UserFriendsRepository userFriendsRepository;

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
        RepositoryProvider<UserFriendsRepository>(
          create: (context) => userFriendsRepository,
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
          BlocProvider(
            create: (context) => FindFriendBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              userProfileRepository:
                  RepositoryProvider.of<UserProfileRepository>(context),
              userFriendsRepository:
                  RepositoryProvider.of<UserFriendsRepository>(context),
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
