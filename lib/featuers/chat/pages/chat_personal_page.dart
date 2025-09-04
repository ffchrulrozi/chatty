import 'package:chatty/featuers/chat/pages/widgets/chat_personal_message_box_widget.dart';
import 'package:chatty/featuers/chat/providers/chat_personal_provider.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/shared/widgets/profile_image_widget.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatPersonalPage extends ConsumerWidget {
  const ChatPersonalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = TextEditingController();
    final receiverName = ref.read(receiverNameProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(PATH.DASHBOARD.path),
        ),
        title: Row(children: [
          ProfileImageWidget(receiverName, 0),
          h(1),
          Text(receiverName)
        ]),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatPersonalMessageBoxWidget()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                      hintText: "Enter message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                h(1),
                InkWell(
                  onTap: () {
                    if (inputController.text.trim().isEmpty) return;
                    ref
                        .read(sendChatNotifierProvider.notifier)
                        .send(inputController.text);
                    inputController.clear();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
