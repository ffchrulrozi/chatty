import 'package:chatty/featuers/chat/models/chat_list.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final currentUserEmailProvider =
    Provider<String>((ref) => FirebaseAuth.instance.currentUser!.email!);

final chatProvider = StreamProvider<List<Chat>>((ref) {
  final currentUserEmail = ref.read(currentUserEmailProvider);
  return FirebaseFirestore.instance
      .collection('chats')
      .where('participants', arrayContains: currentUserEmail)
      .where('updatedBy', isNotEqualTo: '')
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((doc) => Chat.fromDoc(doc)).toList(),
      );
});

final contactProvider = Provider<Future<Map<dynamic, dynamic>>>((ref) async {
  final contactsSnap = await FirebaseFirestore.instance
      .collection('contacts')
      .where('createdBy', isEqualTo: ref.read(currentUserEmailProvider))
      .get();

  final contacts = contactsSnap.docs.map((d) => d.data()).toList();
  final contactMap = {
    for (var c in contacts) c['email']: c['name'],
  };
  return contactMap;
});

final newChatNotifierProvider =
    StateNotifierProvider<NewChatNotifier, void>((ref) {
  final currentUserEmail = ref.read(currentUserEmailProvider);
  return NewChatNotifier(currentUserEmail);
});

class NewChatNotifier extends StateNotifier<void> {
  final String currentUserEmail;
  NewChatNotifier(this.currentUserEmail) : super(null);

  Future<void> newChat(String toEmail) async {
    final String chatId;

    var data = (await FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: currentUserEmail)
            .where('key', isEqualTo: _chatKey(currentUserEmail, toEmail))
            .get())
        .docs;

    if (data.isNotEmpty) {
      chatId = data.first.id;
    } else {
      final chat = NewChat(
        key: _chatKey(currentUserEmail, toEmail),
        participants: [currentUserEmail, toEmail],
      ).toMap();

      chatId =
          (await FirebaseFirestore.instance.collection("chats").add(chat)).id;
    }

    final name = await _getContactName(currentUserEmail, toEmail);

    navigatorKey.currentContext
        ?.go("${PATH.CHAT_PERSONAL.name}/$chatId?name=$name");
  }

  String _chatKey(String currentUserEmail, String toEmail) {
    return currentUserEmail.hashCode <= toEmail.hashCode
        ? "${currentUserEmail}__$toEmail"
        : "${toEmail}__$currentUserEmail";
  }

  Future<String> _getContactName(String currentUserEmail, String toEmail) async {
    final contact = (await FirebaseFirestore.instance
            .collection('contacts')
            .where('createdBy', isEqualTo: currentUserEmail)
            .where('email', isEqualTo: toEmail)
            .get())
        .docs
        .map((d) => d.data())
        .firstOrNull;

    return contact == null ? toEmail : contact['name'].toString();
  }
}
