import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import to handle Firebase Authentication
import 'package:home_front_pk/src/features/chat_section/data/chat_repository.dart';
import 'package:home_front_pk/src/features/chat_section/domain/chat_model.dart';

class ChatScreen extends ConsumerStatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late final String currentUserId; // Correctly handle currentUserId
  late final String currentUserName;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth
        .instance.currentUser; // Get the current user from FirebaseAuth
    if (user != null) {
      currentUserId = user.uid; // Set the currentUserId from Firebase Auth
      currentUserName = user.email ??
          'Unknown'; // You can use email as the name or fetch a displayName
    } else {
      // Handle the case where the user is not logged in
      currentUserId = 'unknown';
      currentUserName = 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatMessagesAsync = ref.watch(getMessagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatMessagesAsync.when(
              data: (messages) {
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUser = message.senderId == currentUserId;

                    return Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? Color.fromARGB(255, 96, 191,
                                  143) // Use blue for the current user
                              : Colors
                                  .grey.shade300, // Use grey for other users
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: isCurrentUser
                                ? Radius.circular(16)
                                : Radius.zero,
                            bottomRight: isCurrentUser
                                ? Radius.zero
                                : Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCurrentUser
                                  ? 'You'
                                  : 'Anonymous', // Use 'You' or the sender ID/name
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              message.content,
                              style: TextStyle(
                                color:
                                    isCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                message.timestamp
                                    .toLocal()
                                    .toString()
                                    .split(' ')[1],
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? Colors.white70
                                      : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Send'),
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      final message = ChatMessage(
                        id: '',
                        senderId: currentUserId, // Send correct current user ID
                        content: _messageController.text.trim(),
                        timestamp: DateTime.now(),
                      );
                      ref.read(sendMessageProvider(message).future);
                      _messageController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
