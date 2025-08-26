import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';

class DashboardNewChatModalWidget extends StatelessWidget {
  const DashboardNewChatModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Email"),
      titleTextStyle: text(context).bodyLarge,
      content: TextFormField(
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [ElevatedButton(onPressed: () => (), child: const Text("Chat"))],
    );
  }
}
