import 'package:chatty/featuers/contact/models/contact.dart';
import 'package:chatty/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final contactStreamingProvider = StreamProvider<List<Contact>>((ref) =>
    FirebaseFirestore.instance
        .collection('contacts')
        .where('createdBy',
            isEqualTo: FirebaseAuth.instance.currentUser!.email!)
        .orderBy('name')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Contact.fromDoc(doc)).toList(),
        ));

final contactNotifierProvider =
    StateNotifierProvider<ContactNotifier, void>((ref) {
  return ContactNotifier(null);
});

class ContactNotifier extends StateNotifier<void> {
  ContactNotifier(super.state);

  Future newContact(String name, String email) async {
    var newContact = NewContact(
      name: name,
      email: email,
      createdBy: FirebaseAuth.instance.currentUser!.email!,
    );

    await FirebaseFirestore.instance
        .collection('contacts')
        .add(newContact.toMap());

    navigatorKey.currentContext?.pop();
  }
}
