import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/chat_section/domain/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> sendMessage(ChatMessage message) async {
    await _firestore.collection('chats').add(message.toMap());
  }

  Stream<List<ChatMessage>> getChatMessages() {
    return _firestore
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatMessage.fromDoc(doc)).toList());
  }
}

// Provider for ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(firestore: FirebaseFirestore.instance);
});
// Provider for sending a chat message
final sendMessageProvider =
    FutureProvider.family<void, ChatMessage>((ref, message) async {
  final repo = ref.watch(chatRepositoryProvider);
  await repo.sendMessage(message);
});

// Provider for streaming chat messages
final getMessagesProvider = StreamProvider<List<ChatMessage>>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getChatMessages();
});
