import 'package:flutter/material.dart';

class ChatPersonalPage extends StatelessWidget {
  const ChatPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal"),
      ),
      body: const Center(
        child: Text("Personal Page"),
      ),
    );
  }
}
