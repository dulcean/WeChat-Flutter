import 'package:flutter/material.dart';

class ButtonUpdate extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const ButtonUpdate({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: AutofillHints.jobTitle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
