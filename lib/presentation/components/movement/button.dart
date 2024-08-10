import 'package:WeChat/configs/app_theme.dart';
import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const UpdateButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: AutofillHints.jobTitle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
