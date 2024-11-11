class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final String type; // 'text', 'image', etc.
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? 'text',
      timestamp:
          DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'content': content,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
