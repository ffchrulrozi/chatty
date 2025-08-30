import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime createdAt;
  final String createdBy;

  const Message({
    required this.text,
    required this.createdAt,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdAt: (map['createdAt']).toDate(),
    );
  }

  factory Message.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message.fromMap(data);
  }
}
