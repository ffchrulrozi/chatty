import 'package:chatty/assets/assets.gen.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/utils/ext/date_ext.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final chatStreaming = ref.watch(chatProvider);

    return chatStreaming.when(
      data: (chats) {
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            var chat = chats[index];
            return InkWell(
              onTap: () =>
                  context.push("${PATH.CHAT_PERSONAL.name}/${chat.id}"),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        Assets.lib.assets.img.logo.path,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    h(1.5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                chat.participants
                                    .where((x) => x != currentUserEmail)
                                    .first,
                                style: text(context).titleMedium,
                              ),
                              const Spacer(),
                              Text(chat.updatedAt.toFormattedDate())
                            ],
                          ),
                          Text(chat.lastMessage)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (e, st) => const Center(child: Text("An error occured")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
