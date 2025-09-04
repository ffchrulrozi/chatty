import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/featuers/contact/models/contact.dart';
import 'package:chatty/featuers/contact/providers/contact_provider.dart';
import 'package:chatty/shared/widgets/profile_image_widget.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListContactPage extends ConsumerWidget {
  const ChatListContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var contactStreaming = ref.watch(contactStreamingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Contact"),
      ),
      body: contactStreaming.when(
        data: (contacts) {
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ChatListContactItemBoxWidget(
                ref,
                contacts[index],
                index
              );
            },
          );
        },
        error: (e, st) => const Center(child: Text("An error occured")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ChatListContactItemBoxWidget extends StatelessWidget {
  final WidgetRef ref;
  final Contact contact;
  final int index;
  const ChatListContactItemBoxWidget(this.ref, this.contact, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          ref.read(newChatNotifierProvider.notifier).newChat(contact.email),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ProfileImageWidget(contact.name, index),
            h(1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: text(context).titleMedium,
                ),
                Text(contact.email),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
