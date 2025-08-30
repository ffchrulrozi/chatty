import 'package:chatty/featuers/chat/models/chat_list.dart';
import 'package:chatty/featuers/chat/models/message.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final receiverEmailProvider =
    Provider<String>((ref) => throw UnimplementedError());

final chatIdProvider = Provider<String>((ref) => throw UnimplementedError());

final messageProvider = StreamProvider<List<Message>>((ref) {
  final chatId = ref.read(chatIdProvider);
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((doc) => Message.fromDoc(doc)).toList(),
      );
});

final inputChat = StateProvider<String>((ref) => "");

final sendChatNotifierProvider =
    StateNotifierProvider<SendChatNotifier, void>((ref) {
  final chatId = ref.read(chatIdProvider);
  final myEmail = ref.read(myEmailProvider);

  return SendChatNotifier(chatId, myEmail);
});

class SendChatNotifier extends StateNotifier<void> {
  final String chatId;
  final String myEmail;
  SendChatNotifier(this.chatId, this.myEmail) : super(null);
  Future<void> send(String text) async {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final currentChat =
        FirebaseFirestore.instance.collection('chats').doc(chatId);

    final newMessage = Message(
      text: text,
      createdAt: DateTime.now(),
      createdBy: currentUserEmail,
    ).toMap();

    final updatedChat = UpdateChat(
      lastMessage: text,
      updatedAt: DateTime.now(),
      updatedBy: currentUserEmail,
    ).toMap();

    await currentChat.collection('messages').add(newMessage);
    await currentChat.update(updatedChat);
  }
}
