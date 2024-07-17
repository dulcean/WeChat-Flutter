import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextBoxUpd extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const TextBoxUpd({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[700]),
              ),
              IconButton(onPressed: onPressed, icon: const Icon(Icons.settings))
            ],
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
