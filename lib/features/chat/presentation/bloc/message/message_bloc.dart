import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'package:vanish_link/features/chat/domain/services/unread_service.dart';
import 'message_event.dart';
import 'message_state.dart';

export 'message_event.dart';
export 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  final FirebaseAuth _firebaseAuth;
  String? _currentChatId;
  StreamSubscription<List<Message>>? _messagesSub;
  StreamSubscription<List<String>>? _typingSub;
  final List<Message> _localMessages = [];
  List<String> _typingUsers = [];

  MessageBloc({
    required MessageRepository messageRepository,
    FirebaseAuth? firebaseAuth,
  })  : _messageRepository = messageRepository,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const MessageState.initial()) {

    on<LoadMessages>((event, emit) {
      emit(const MessageState.loading());
      _currentChatId = event.chatId;
      UnreadService.activeChatId = event.chatId;
      _localMessages.clear();
      _typingUsers.clear();

      final currentUserId = _firebaseAuth.currentUser?.uid;

      // Mark the chat as read
      if (currentUserId != null) {
        _messageRepository.markChatAsRead(chatId: event.chatId, userId: currentUserId);
        _messageRepository.markMessagesAsRead(chatId: event.chatId, currentUserId: currentUserId);
      }

      _messagesSub?.cancel();
      _messagesSub = _messageRepository.watchMessages(event.chatId).listen(
        (messages) {
          if (!isClosed) {
            add(MessageEvent.messagesUpdated(messages));
          }
        },
        onError: (e) {
          if (!isClosed) {
            emit(MessageState.error(e.toString()));
          }
        },
      );

      _typingSub?.cancel();
      _typingSub = _messageRepository.watchTypingUsers(chatId: event.chatId, currentUserId: currentUserId ?? '').listen(
        (users) {
          if (!isClosed) {
            add(MessageEvent.typingUsersUpdated(users));
          }
        },
      );
    });

    on<MessagesUpdated>((event, emit) async {
      final messages = event.messages;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      final chatId = _currentChatId;

      if (currentUserId != null && chatId != null) {
        final isChatVisible = UnreadService.isAppInForeground &&
            UnreadService.activeChatId == chatId;

        if (isChatVisible) {
          bool updatedAny = false;
          for (final msg in messages) {
            if (msg.receiverId == currentUserId && msg.status != 'read') {
              // Update to read in the database
              await _messageRepository.updateMessageStatus(
                chatId: chatId,
                messageId: msg.messageId,
                status: 'read',
              );
              updatedAny = true;
            }
          }
          if (updatedAny) {
            await _messageRepository.markChatAsRead(chatId: chatId, userId: currentUserId);
          }
        }
      }

      // Filter local messages to remove any that are now in the database
      final dbMessageIds = messages.map((m) => m.messageId).toSet();
      _localMessages.removeWhere((msg) => dbMessageIds.contains(msg.messageId));

      // Filter out messages that are deleted for the current user (Delete For Me)
      final visibleMessages = messages.where((msg) {
        if (currentUserId == null) return true;
        return msg.deletedForUsers[currentUserId] != true;
      }).toList();

      final allMessages = [...visibleMessages, ..._localMessages];
      allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      if (allMessages.isEmpty) {
        emit(const MessageState.empty());
      } else {
        emit(MessageState.loaded(allMessages, typingUsers: _typingUsers));
      }
    });

    on<TypingUsersUpdated>((event, emit) {
      _typingUsers = event.typingUsers;
      state.mapOrNull(
        loaded: (s) {
          emit(s.copyWith(typingUsers: _typingUsers));
        },
      );
    });

    on<SendMessage>((event, emit) async {
      final chatId = _currentChatId;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      if (chatId == null || currentUserId == null) return;

      final receiverId = _getReceiverId(chatId, currentUserId);
      if (receiverId.isEmpty) return;

      final messageId = 'failed_${DateTime.now().millisecondsSinceEpoch}';
      final createdAt = DateTime.now();
      final expiresAt = createdAt.add(const Duration(hours: 6));

      final failedMessage = Message(
        messageId: messageId,
        chatId: chatId,
        senderId: currentUserId,
        receiverId: receiverId,
        type: 'text',
        content: event.content,
        createdAt: createdAt,
        expiresAt: expiresAt,
        status: 'failed',
        replyToMessageId: event.replyToMessageId,
        replyToSenderId: event.replyToSenderId,
        replyToPreview: event.replyToPreview,
      );

      try {
        await _messageRepository.sendMessage(
          chatId: chatId,
          senderId: currentUserId,
          receiverId: receiverId,
          content: event.content,
          replyToMessageId: event.replyToMessageId,
          replyToSenderId: event.replyToSenderId,
          replyToPreview: event.replyToPreview,
        );
      } catch (e) {
        _localMessages.add(failedMessage);
        final currentMessages = state.maybeMap(
          loaded: (s) => s.messages,
          orElse: () => <Message>[],
        );
        emit(MessageState.loaded([...currentMessages, failedMessage], typingUsers: _typingUsers));
      }
    });

    on<MessageDelivered>((event, emit) async {
      final chatId = _currentChatId;
      if (chatId == null) return;
      await _messageRepository.updateMessageStatus(
        chatId: chatId,
        messageId: event.messageId,
        status: 'delivered',
      );
    });

    on<MessageRead>((event, emit) async {
      final chatId = _currentChatId;
      if (chatId == null) return;
      await _messageRepository.updateMessageStatus(
        chatId: chatId,
        messageId: event.messageId,
        status: 'read',
      );
    });

    on<MarkAsRead>((event, emit) async {
      final chatId = _currentChatId;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      if (chatId != null && currentUserId != null) {
        await _messageRepository.markChatAsRead(chatId: chatId, userId: currentUserId);
        await _messageRepository.markMessagesAsRead(chatId: chatId, currentUserId: currentUserId);
      }
    });

    on<RetryMessage>((event, emit) async {
      final chatId = _currentChatId;
      if (chatId == null) return;

      _localMessages.removeWhere((msg) => msg.messageId == event.message.messageId);

      try {
        await _messageRepository.retryMessage(
          chatId: chatId,
          message: event.message,
        );
      } catch (e) {
        _localMessages.add(event.message);
        final currentMessages = state.maybeMap(
          loaded: (s) => s.messages,
          orElse: () => <Message>[],
        );
        emit(MessageState.loaded([...currentMessages, event.message], typingUsers: _typingUsers));
      }
    });

    on<EditMessage>((event, emit) async {
      final chatId = _currentChatId;
      if (chatId != null) {
        await _messageRepository.editMessage(
          chatId: chatId,
          messageId: event.messageId,
          newContent: event.newContent,
        );
      }
    });

    on<DeleteMessage>((event, emit) async {
      final chatId = _currentChatId;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      if (chatId != null) {
        if (event.forEveryone) {
          await _messageRepository.deleteMessageForEveryone(
            chatId: chatId,
            messageId: event.messageId,
          );
        } else if (currentUserId != null) {
          await _messageRepository.deleteMessageForMe(
            chatId: chatId,
            messageId: event.messageId,
            userId: currentUserId,
          );
        }
      }
    });

    on<UpdateReaction>((event, emit) async {
      final chatId = _currentChatId;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      if (chatId != null && currentUserId != null) {
        await _messageRepository.updateReaction(
          chatId: chatId,
          messageId: event.messageId,
          userId: currentUserId,
          reaction: event.reaction,
        );
      }
    });

    on<SetTyping>((event, emit) async {
      final chatId = _currentChatId;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      if (chatId != null && currentUserId != null) {
        await _messageRepository.setTypingStatus(
          chatId: chatId,
          userId: currentUserId,
          isTyping: event.isTyping,
        );
      }
    });
  }

  /// Extracts the receiver's UID from a deterministic chatId.
  /// chatId format: "uidA_uidB" where uidA < uidB alphabetically.
  /// Cannot naively split on '_' because UIDs themselves may contain underscores.
  String _getReceiverId(String chatId, String currentUserId) {
    if (chatId.startsWith('${currentUserId}_')) {
      return chatId.substring(currentUserId.length + 1);
    } else if (chatId.endsWith('_$currentUserId')) {
      return chatId.substring(0, chatId.length - currentUserId.length - 1);
    }
    return '';
  }

  @override
  Future<void> close() {
    _messagesSub?.cancel();
    _typingSub?.cancel();
    if (UnreadService.activeChatId == _currentChatId) {
      UnreadService.activeChatId = null;
    }
    return super.close();
  }
}
