import 'package:chatty/assets/assets.gen.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPersonalPage extends ConsumerWidget {
  const ChatPersonalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser!;
    final firestore = FirebaseFirestore.instance;
    var chatId = ref.read(chatIdProvider);
    var receiverEmail = ref.read(receiverEmailProvider);
    final inputController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          ClipOval(
            child: Image.asset(
              Assets.lib.assets.img.logo.path,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          h(1),
          Text(receiverEmail)
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index].data() as Map<String, dynamic>;
                    var isByMe = msg["senderEmail"] == user.email;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      alignment:
                          isByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Card(
                        color: isByMe ? Colors.blue : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            msg['text'] ?? '',
                            style: text(context).bodyLarge!.copyWith(
                                color: isByMe ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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
