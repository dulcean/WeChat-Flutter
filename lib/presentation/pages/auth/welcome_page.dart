import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/configs/router_constants.dart';
import 'package:WeChat/presentation/components/movement/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.lightTheme.scaffoldBackgroundColor,
              const Color.fromARGB(255, 80, 176, 255),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/bow.json',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Text(
                  'Welcome to WeChat,\nthe greatest app to chat \never',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: UpdateButton(
                onTap: () {
                  GoRouter.of(context).pushNamed(RouterConstants.register);
                },
                text: 'Next',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
