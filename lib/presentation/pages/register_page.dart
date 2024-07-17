import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/presentation/components/button.dart';
import 'package:we_chat/presentation/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (confirmPasswordController.text != passwordController.text) {
      Navigator.pop(context);
      displayMessage("Password unmatched");
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordController.text,
      );

      //NEW USER -> FIREBASE
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email).set({
            'username': emailTextController.text.split('@')[0],
            'bio': 'Empty bio...',
          });

      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
        child: SingleChildScrollView(
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
                    "Lets create an account",
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
                    height: 10,
                  ),
                  TextFieldUpdate(
                      controller: confirmPasswordController,
                      hintText: "Confirm password",
                      obsecureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonUpdate(
                    onTap: signUp,
                    text: 'Sign up',
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have? ",
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
                          "Login!",
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
      ),
    );
  }
}
