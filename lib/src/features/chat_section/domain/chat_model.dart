import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId; // The ID of the user sending the message
  final String content; // The message content
  final DateTime timestamp; // The timestamp of the message

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory ChatMessage.fromDoc(DocumentSnapshot doc) {
    return ChatMessage(
      id: doc.id,
      senderId: doc['senderId'] as String,
      content: doc['content'] as String,
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    );
  }
}
