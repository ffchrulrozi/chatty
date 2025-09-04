import 'package:chatty/featuers/chat/providers/chat_personal_provider.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPersonalMessageBoxWidget extends ConsumerWidget {
  const ChatPersonalMessageBoxWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserEmail = ref.read(currentUserEmailProvider);
    final messageStreming = ref.watch(messageProvider);

    return messageStreming.when(
      data: (messages) {
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            var isByMe = message.createdBy == currentUserEmail;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: isByMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Card(
                color: isByMe ? Colors.blue : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message.text,
                    style: text(context)
                        .bodyLarge!
                        .copyWith(color: isByMe ? Colors.white : Colors.black),
                  ),
                ),
              ),
            );
          },
        );
      },
      error: (e, st) => const Center(child: Text("an error occured")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

