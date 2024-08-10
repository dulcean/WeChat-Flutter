import 'package:flutter/material.dart';

import '../../../configs/app_theme.dart';

class UpdatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Color background;
  final bool showSuffixIcon;
  final ValueChanged<String>? onChanged;

  const UpdatedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.background,
    this.showSuffixIcon = false,
    required this.obsecureText,
    this.onChanged,
  });

  @override
  State<UpdatedTextField> createState() => _UpdatedTextFieldState();
}

class _UpdatedTextFieldState extends State<UpdatedTextField> {
  bool _isFocused = false;
  late bool _isObsecured;
  @override
  void initState() {
    super.initState();
    _isObsecured = widget.obsecureText;
  }

  void setObsecureText(bool value) {
    setState(() {
      _isObsecured = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: TweenAnimationBuilder(
        tween: ColorTween(
          begin: AppTheme.lightTheme.primaryColor.withOpacity(0.9),
          end: _isFocused
              ? AppTheme.lightTheme.primaryColor
              : AppTheme.lightTheme.primaryColor.withOpacity(0.9),
        ),
        duration: const Duration(milliseconds: 300),
        builder: (context, Color? color, child) {
          return TextField(
            onChanged: widget.onChanged,
            controller: widget.controller,
            obscureText: _isObsecured,
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: TextStyle(
                color: color,
                fontSize: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(
                color: color,
                fontSize: 18,
              ),
              filled: true,
              fillColor: widget.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: color!,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: color,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: color,
                  width: 2,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              suffixIcon: widget.showSuffixIcon
                  ? InkWell(
                      onTap: () {
                        setObsecureText(!_isObsecured);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: _isObsecured
                            ? Icon(
                                Icons.visibility_off,
                                key: const ValueKey('obscured'),
                                color: color,
                              )
                            : Icon(
                                Icons.visibility,
                                key: const ValueKey('visible'),
                                color: color,
                              ),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
