import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String name;
  final String email;

  const Contact({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Contact.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Contact(
      id: doc.id,
      name: data['name'],
      email: data['email'],
    );
  }
}

class NewContact {
  final String createdBy;
  final String name;
  final String email;

  const NewContact({
    required this.createdBy,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'name': name,
      'email': email,
    };
  }
}

class EditContact {
  final String name;
  final String email;

  const EditContact({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}

class DetailContact {
  final String name;
  final String email;

  const DetailContact({
    required this.name,
    required this.email,
  });

  factory DetailContact.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DetailContact(
      name: data['name'],
      email: data['email'],
    );
  }
}
