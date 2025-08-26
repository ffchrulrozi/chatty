import 'package:flutter/material.dart';

class ChatGroupPage extends StatelessWidget {
  const ChatGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
      ),
      body: const Center(
        child: Text("Group Page"),
      ),
    );
  }
}
