import 'package:chatty/featuers/contact/models/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactDetailIdProvider = Provider<String?>((ref) => null);

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
  final contactId = ref.read(contactDetailIdProvider);
  return ContactNotifier(contactId, null);
});

class ContactNotifier extends StateNotifier<void> {
  final String? contactId;
  ContactNotifier(this.contactId, super.state);

  Future<DetailContact?> detailContact() async {
    if (contactId != null) {
      final res = await FirebaseFirestore.instance
          .collection('contacts')
          .doc(contactId)
          .get();

      return DetailContact.fromDoc(res);
    } else {
      return null;
    }
  }

  Future create(String name, String email) async {
    var newContact = NewContact(
      name: name,
      email: email,
      createdBy: FirebaseAuth.instance.currentUser!.email!,
    );

    await FirebaseFirestore.instance
        .collection('contacts')
        .add(newContact.toMap());
  }

  Future update(String name, String email) async {
    var editContact = EditContact(
      name: name,
      email: email,
    );

    await FirebaseFirestore.instance
        .collection('contacts')
        .doc(contactId)
        .update(editContact.toMap());
  }

  Future<void> delete() async {
    await FirebaseFirestore.instance
        .collection("contacts")
        .doc(contactId)
        .delete();
  }
}
