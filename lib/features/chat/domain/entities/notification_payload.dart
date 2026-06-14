enum NotificationType {
  incomingCall,
  missedCall,
  callDeclined,
  callEnded,
  newMessage,
  messageReaction,
  mention,
  system,
}

class NotificationPayload {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String? senderId;
  final String? receiverId;
  final String? callId;
  final String? chatId;
  final DateTime createdAt;
  final Map<String, dynamic>? data;

  const NotificationPayload({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.senderId,
    this.receiverId,
    this.callId,
    this.chatId,
    required this.createdAt,
    this.data,
  });

  factory NotificationPayload.fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String? ?? 'system';
    final NotificationType type;
    switch (typeString) {
      case 'incomingCall':
        type = NotificationType.incomingCall;
        break;
      case 'missedCall':
        type = NotificationType.missedCall;
        break;
      case 'callDeclined':
        type = NotificationType.callDeclined;
        break;
      case 'callEnded':
        type = NotificationType.callEnded;
        break;
      case 'newMessage':
        type = NotificationType.newMessage;
        break;
      case 'messageReaction':
        type = NotificationType.messageReaction;
        break;
      case 'mention':
        type = NotificationType.mention;
        break;
      case 'system':
      default:
        type = NotificationType.system;
        break;
    }

    final createdAtRaw = json['createdAt'];
    DateTime createdAt = DateTime.now();
    if (createdAtRaw is int) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(createdAtRaw);
    } else if (createdAtRaw is String) {
      createdAt = DateTime.tryParse(createdAtRaw) ?? DateTime.now();
    }

    return NotificationPayload(
      id: json['id'] as String? ?? '',
      type: type,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      callId: json['callId'] as String?,
      chatId: json['chatId'] as String?,
      createdAt: createdAt,
      data: json['data'] is Map ? Map<String, dynamic>.from(json['data'] as Map) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'body': body,
      'senderId': senderId,
      'receiverId': receiverId,
      'callId': callId,
      'chatId': chatId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'data': data,
    };
  }
}
