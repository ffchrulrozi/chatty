import 'package:cloud_firestore/cloud_firestore.dart';

class NewChat {
  final String key;
  final List<String> participants;
  final String? lastMessage;
  final DateTime? updatedAt;
  final String? updatedBy;

  NewChat({
    required this.key,
    required this.participants,
    this.lastMessage,
    this.updatedAt,
    this.updatedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'participants': FieldValue.arrayUnion(participants),
      'lastMessage': lastMessage ?? '',
      'updatedAt': updatedAt ?? DateTime.now(),
      'updatedBy': updatedBy ?? '',
    };
  }
}

class UpdateChat {
  final String lastMessage;
  final DateTime updatedAt;
  final String updatedBy;

  UpdateChat({
    required this.updatedAt,
    required this.lastMessage,
    required this.updatedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'lastMessage': lastMessage,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
    };
  }
}

class Chat {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime updatedAt;
  final String updatedBy;

  Chat({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory Chat.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      id: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      updatedBy: data['updatedBy'] ?? '',
    );
  }
}
