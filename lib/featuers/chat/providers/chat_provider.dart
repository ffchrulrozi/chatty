import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatIdProvider = Provider<String>((ref) => throw UnimplementedError());
final receiverEmailProvider =
    Provider<String>((ref) => throw UnimplementedError());
final inputChat = StateProvider<String>((ref) => "");

final sendChatNotifierProvider =
    StateNotifierProvider<SendChatNotifier, void>((ref) {
  final receiverEmail = ref.watch(receiverEmailProvider);
  final chatId = ref.watch(chatIdProvider);

  return SendChatNotifier(chatId, receiverEmail);
});

class SendChatNotifier extends StateNotifier<void> {
  final String chatId;
  final String receiverEmail;
  SendChatNotifier(this.chatId, this.receiverEmail) : super(null);

  Future<void> send(String text) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'senderEmail': FirebaseAuth.instance.currentUser!.email,
      'receiverEmail': receiverEmail
    });
  }
}
