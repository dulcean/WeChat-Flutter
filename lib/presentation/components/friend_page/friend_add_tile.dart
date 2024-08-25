import 'package:flutter/material.dart';

import '../../../configs/app_theme.dart';

class FriendAddTile extends StatefulWidget {
  const FriendAddTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.backgroundColor,
  });

  final String title;
  final String subtitle;
  final String avatarUrl;
  final Color backgroundColor;

  @override
  // ignore: library_private_types_in_public_api
  _FriendAddTileState createState() => _FriendAddTileState();
}

class _FriendAddTileState extends State<FriendAddTile> {
  bool isFriendAdded = false;

  void toggleFriendStatus() {
    setState(() {
      isFriendAdded = !isFriendAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: widget.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.lightTheme.primaryColor,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.avatarUrl),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '@${widget.subtitle}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: toggleFriendStatus,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isFriendAdded ? Icons.check : Icons.add,
                  color: AppTheme.lightTheme.primaryColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
