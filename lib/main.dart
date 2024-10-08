import 'package:WeChat/firebase_options.dart';
import 'package:WeChat/presentation/pages/application.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_repository/user_repository.dart';

import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  Bloc.observer = SimpleBlocObserver();

  final userRepository = FirebaseUserRepository();
  final userProfileRepository = FirebaseUserProfileRepository();
  final userFriendsRepository = FirebaseUserFriendsRepository();
  runApp(Application(
    userRepository: userRepository,
    userProfileRepository: userProfileRepository,
    userFriendsRepository: userFriendsRepository,
  ));
}
