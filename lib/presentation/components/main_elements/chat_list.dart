import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, indx) => Container(),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: 3);
  }
}
