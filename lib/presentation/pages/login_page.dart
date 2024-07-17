import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/presentation/components/button.dart';
import 'package:we_chat/presentation/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Create DTO controllers
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordController.text,
    );
    if (mounted) Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    if (mounted) Navigator.pop(context);
    displayMessage(e.code);
  }
}


  void displayMessage(String displayedMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(displayedMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFieldUpdate(
                    controller: emailTextController,
                    hintText: "Email",
                    obsecureText: false),
                const SizedBox(
                  height: 10,
                ),
                TextFieldUpdate(
                    controller: passwordController,
                    hintText: "Password",
                    obsecureText: true),
                const SizedBox(
                  height: 20,
                ),
                ButtonUpdate(
                  onTap: signIn,
                  text: 'Sign in',
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member? ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register!",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
