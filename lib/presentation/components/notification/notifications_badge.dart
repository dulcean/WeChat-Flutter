import 'package:flutter/material.dart';

class NotificationsBadge extends StatelessWidget {
  final int count;

  const NotificationsBadge({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return count > 0
        ? Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : const SizedBox();
  }
}