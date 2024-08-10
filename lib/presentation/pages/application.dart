import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/configs/router_paths.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // home: const AuthPage(),
      routerConfig: RouterPaths().router,
    );
  }
}
