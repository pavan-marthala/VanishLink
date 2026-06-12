class Message {
  final String messageId;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String type; // 'text', 'image', 'file', 'system'
  final String content;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String status; // 'sending', 'sent', 'delivered', 'read', 'failed'

  // Replies
  final String? replyToMessageId;
  final String? replyToSenderId;
  final String? replyToPreview;

  // Edits
  final bool edited;
  final DateTime? editedAt;

  // Deletes
  final bool isDeleted;
  final DateTime? deletedAt;

  // Reactions & Delete For Me
  final Map<String, String> reactions; // userId -> emoji
  final Map<String, bool> deletedForUsers; // userId -> true/false

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
    this.replyToMessageId,
    this.replyToSenderId,
    this.replyToPreview,
    this.edited = false,
    this.editedAt,
    this.isDeleted = false,
    this.deletedAt,
    this.reactions = const {},
    this.deletedForUsers = const {},
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
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      if (replyToSenderId != null) 'replyToSenderId': replyToSenderId,
      if (replyToPreview != null) 'replyToPreview': replyToPreview,
      'edited': edited,
      if (editedAt != null) 'editedAt': editedAt!.millisecondsSinceEpoch,
      'isDeleted': isDeleted,
      if (deletedAt != null) 'deletedAt': deletedAt!.millisecondsSinceEpoch,
      'reactions': reactions,
      'deletedForUsers': deletedForUsers,
    };
  }

  factory Message.fromMap(Map<dynamic, dynamic> map) {
    // Parse reactions
    final Map<String, String> parsedReactions = {};
    if (map['reactions'] is Map) {
      (map['reactions'] as Map).forEach((k, v) {
        parsedReactions[k.toString()] = v.toString();
      });
    }

    // Parse deletedForUsers
    final Map<String, bool> parsedDeletedFor = {};
    if (map['deletedForUsers'] is Map) {
      (map['deletedForUsers'] as Map).forEach((k, v) {
        parsedDeletedFor[k.toString()] = v == true;
      });
    }

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
      replyToMessageId: map['replyToMessageId'] as String?,
      replyToSenderId: map['replyToSenderId'] as String?,
      replyToPreview: map['replyToPreview'] as String?,
      edited: map['edited'] as bool? ?? false,
      editedAt: map['editedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['editedAt'] as int)
          : null,
      isDeleted: map['isDeleted'] as bool? ?? false,
      deletedAt: map['deletedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int)
          : null,
      reactions: parsedReactions,
      deletedForUsers: parsedDeletedFor,
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
    String? replyToMessageId,
    String? replyToSenderId,
    String? replyToPreview,
    bool? edited,
    DateTime? editedAt,
    bool? isDeleted,
    DateTime? deletedAt,
    Map<String, String>? reactions,
    Map<String, bool>? deletedForUsers,
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
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      replyToSenderId: replyToSenderId ?? this.replyToSenderId,
      replyToPreview: replyToPreview ?? this.replyToPreview,
      edited: edited ?? this.edited,
      editedAt: editedAt ?? this.editedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      reactions: reactions ?? this.reactions,
      deletedForUsers: deletedForUsers ?? this.deletedForUsers,
    );
  }
}
