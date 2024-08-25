import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final String imgPath;
  final String topTag;
  final String bottomTag;
  const FriendCard({
    super.key,
    required this.imgPath,
    required this.topTag,
    required this.bottomTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            child: Image.asset(
              imgPath,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Column(children: [
              Text(
                topTag,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                bottomTag,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black26,
                ),
                textAlign: TextAlign.left,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
