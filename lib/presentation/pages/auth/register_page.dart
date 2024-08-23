import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/gen/assets.gen.dart';
import 'package:WeChat/presentation/components/movement/button.dart';
import 'package:WeChat/presentation/components/text_editing/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

import '../../../blocs/auth/register/register_bloc.dart';
import '../../../configs/router_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool registerRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          setState(() {
            registerRequired = false;
          });
          GoRouter.of(context).pushReplacementNamed(RouterConstants.home);
        } else if (state is RegisterProcess) {
          setState(() {
            registerRequired = true;
          });
        } else if (state is RegisterFailure) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
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
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Fill up your details to register.',
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
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    UpdatedTextField(
                      controller: nameTextController,
                      hintText: 'Name',
                      obsecureText: false,
                      background: AppTheme.lightTheme.scaffoldBackgroundColor,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    UpdatedTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obsecureText: true,
                      background: AppTheme.lightTheme.scaffoldBackgroundColor,
                      showSuffixIcon: true,
                    ),
                    const SizedBox(height: 68),
                    UpdateButton(
                      onTap: () {
                        WeUser user = WeUser.empty;
                        user.email = emailTextController.text;
                        user.name = nameTextController.text;
                        setState(() {
                          context.read<RegisterBloc>().add(
                              RegisterRequired(user, passwordController.text));
                        });
                      },
                      text: 'Register',
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushReplacementNamed(RouterConstants.login);
                          },
                          child: Text(
                            "Login!",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.lightTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30), // Space before bottom
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
