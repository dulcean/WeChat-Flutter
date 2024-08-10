import 'package:WeChat/firebase_options.dart';
import 'package:WeChat/presentation/pages/application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // final AuthenticationRepository authRepository =
  //     AuthenticationRepository();
  // final UserDataRepository dataRepository = UserDataRepository();
  // final StorageRepository storeRepository = StorageRepository();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Application());
}
