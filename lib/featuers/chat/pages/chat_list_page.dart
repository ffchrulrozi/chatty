import 'package:chatty/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.push(PATH.CHAT_PERSONAL),
            child: const Text("Chat Personal"),
          ),
          ElevatedButton(
            onPressed: () => context.push(PATH.CHAT_GROUP),
            child: const Text("Chat Group"),
          )
        ],
      ),
    );
  }
}
