import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/configs/router_constants.dart';
import 'package:WeChat/gen/assets.gen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      GoRouter.of(context).go(RouterConstants.authenticationPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppTheme.lightTheme.primaryColor,
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.splash.background.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AnimatedSplashScreen(
          splash: LottieBuilder.asset(
            'assets/lottie/logo_animation.json',
            width: 400,
            height: 400,
          ),
          backgroundColor: Colors.transparent,
          nextScreen: Container(),
          duration: 5000,
        ),
      ],
    );
  }
}
