import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/gen/assets.gen.dart';
import 'package:WeChat/presentation/components/movement/button.dart';
import 'package:WeChat/presentation/components/text_editing/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/auth/login/login_bloc.dart';
import '../../../configs/router_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  bool loginRequired = false;
  // ignore: unused_field
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess) {
          setState(() {
            loginRequired = false;
            GoRouter.of(context).go('/auth');
          });
        } else if (state is LoginProcess) {
          setState(() {
            loginRequired = true;
          });
        } else if (state is LoginFailure) {
          setState(() {
            loginRequired = false;
            _errorMsg = 'Invalid email or password';
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: BlocProvider(
          create: (_) => _loginBloc,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.primaryColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).pop();
                            },
                            child:
                                Image.asset(Assets.images.icons.arrowIcon.path),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter your email to continue.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 88),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      UpdatedTextField(
                        controller: emailTextController,
                        hintText: 'Email',
                        obsecureText: false,
                        background: AppTheme.lightTheme.scaffoldBackgroundColor,
                      ),
                      const SizedBox(height: 16),
                      UpdatedTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obsecureText: true,
                        background: AppTheme.lightTheme.scaffoldBackgroundColor,
                        showSuffixIcon: true,
                      ),
                      const SizedBox(height: 25),
                      !loginRequired?
                      UpdateButton(
                        onTap: () {
                          setState(() {
                            context.read<LoginBloc>().add(
                              LoginRequired(emailTextController.text, passwordController.text,),
                            );
                          });
                        },
                        text: 'Login',
                      ) : const CircularProgressIndicator(),

                      const SizedBox(height: 173),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not a member? ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushReplacementNamed(
                                  RouterConstants.register);
                            },
                            child: Text(
                              "Register!",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.lightTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
