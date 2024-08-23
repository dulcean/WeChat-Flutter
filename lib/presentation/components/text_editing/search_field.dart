import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SearchArea extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function()? onTap;

  const SearchArea({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onTap,
  });

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            prefixIcon: Image.asset(Assets.images.icons.wIcon.path),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            border: InputBorder.none,
            suffixIcon: InkWell(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(Assets.images.icons.searchIcon.path),
              ),
            )),
      ),
    );
  }
}
