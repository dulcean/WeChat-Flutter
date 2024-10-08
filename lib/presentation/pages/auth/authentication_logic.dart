// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:WeChat/blocs/authentication/authentication_bloc.dart';
import 'package:WeChat/presentation/components/movement/circular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

import '../../../configs/router_constants.dart';

class AuthenticationLogic extends StatelessWidget {
  const AuthenticationLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        try {
          if (state.status == AuthenticationStatus.authenticated) {
            final userId = state.user?.userId;
            if (userId != null) {
              final userProfileRepository = RepositoryProvider.of<UserProfileRepository>(context);
              final isComplete =
                  await userProfileRepository.isProfileComplete(userId);
              if (isComplete) {
                log('Navigating to HomePage');
                context.go(RouterConstants.homePath);
              } else {
                log('Navigating to EditingPage');
                context.go(RouterConstants.profileFillPath, extra: userId);
              }
            } else {
              log('Error: User ID is null or user is not authenticated.');
            }
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            log('Navigating to WelcomePage');
            context.go(RouterConstants.welcomePath);
          }
        } catch (e) {
          log('Error in AuthenticationLogic listener: $e');
        }
      },
      child: const Scaffold(
        body: Center(child: GradientCircularProgressIndicator()),
      ),
    );
  }
}
