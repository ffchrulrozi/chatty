import 'package:chatty/featuers/chat/models/chat_list.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final myEmailProvider =
    Provider<String>((ref) => FirebaseAuth.instance.currentUser!.email!);

final chatProvider = StreamProvider<List<Chat>>((ref) {
  final myEmail = ref.read(myEmailProvider);
  return FirebaseFirestore.instance
      .collection('chats')
      .where('participants', arrayContains: myEmail)
      .where('updatedBy', isNotEqualTo: '')
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((doc) => Chat.fromDoc(doc)).toList(),
      );
});

final newChatNotifierProvider =
    StateNotifierProvider<NewChatNotifier, void>((ref) {
  final myEmail = ref.read(myEmailProvider);
  return NewChatNotifier(myEmail);
});

class NewChatNotifier extends StateNotifier<void> {
  final String myEmail;
  NewChatNotifier(this.myEmail) : super(null);

  Future<void> newChat(String toEmail) async {
    final chat = NewChat(
      participants: <String>[myEmail, toEmail],
    ).toMap();

    final refChat =
        await FirebaseFirestore.instance.collection("chats").add(chat);

    navigatorKey.currentContext
        ?.push("${PATH.CHAT_PERSONAL.name}/${refChat.id}");
  }
}
