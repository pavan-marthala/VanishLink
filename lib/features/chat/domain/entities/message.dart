class Message {
  final String messageId;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String type; // 'text', 'image', 'file', 'system'
  final String content;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String status; // 'sending', 'sent', 'delivered', 'read'

  const Message({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
    required this.createdAt,
    required this.expiresAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'expiresAt': expiresAt.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String? ?? '',
      chatId: map['chatId'] as String? ?? '',
      senderId: map['senderId'] as String? ?? '',
      receiverId: map['receiverId'] as String? ?? '',
      type: map['type'] as String? ?? 'text',
      content: map['content'] as String? ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int? ?? 0),
      expiresAt: DateTime.fromMillisecondsSinceEpoch(map['expiresAt'] as int? ?? 0),
      status: map['status'] as String? ?? 'sent',
    );
  }

  Message copyWith({
    String? messageId,
    String? chatId,
    String? senderId,
    String? receiverId,
    String? type,
    String? content,
    DateTime? createdAt,
    DateTime? expiresAt,
    String? status,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
    );
  }
}
