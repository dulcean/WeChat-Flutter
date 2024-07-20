import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'like_button.dart';

class WallPost extends StatefulWidget {
  final String postMessage;
  final String user;
  final String postID;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.postMessage,
    required this.user,
    required this.likes,
    required this.postID,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //Fire docs
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postID);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  String formatLikes(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(
        top: 25,
        left: 25,
        right: 25,
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // Container(
          //   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[400]),
          //   padding: const EdgeInsets.all(10),
          //   child: const Icon(Icons.person, color: Colors.white,),
          // ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LikeButton(isLiked: isLiked, onTap: toggleLike),
              const SizedBox(
                height: 5,
              ),
              Text(
                formatLikes(widget.likes.length),
                style:
                    TextStyle(color: isLiked ? Colors.red : Colors.grey[500]),
              ),
            ],
          ),
          // const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.postMessage,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                // const SizedBox(height: 10),
                // Text(widget.postMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
