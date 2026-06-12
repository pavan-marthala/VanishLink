import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'message_event.dart';
import 'message_state.dart';

export 'message_event.dart';
export 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  final FirebaseAuth _firebaseAuth;
  String? _currentChatId;
  StreamSubscription<List<Message>>? _messagesSub;

  MessageBloc({
    required MessageRepository messageRepository,
    FirebaseAuth? firebaseAuth,
  })  : _messageRepository = messageRepository,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const MessageState.initial()) {

    on<LoadMessages>((event, emit) {
      emit(const MessageState.loading());
      _currentChatId = event.chatId;

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
    });

    on<MessagesUpdated>((event, emit) async {
      final messages = event.messages;

      // Automatically update status of any incoming messages that are still marked as 'sent'
      final currentUserId = _firebaseAuth.currentUser?.uid;
      final chatId = _currentChatId;

      if (currentUserId != null && chatId != null) {
        for (final msg in messages) {
          if (msg.receiverId == currentUserId && msg.status == 'sent') {
            // Update to delivered in the database
            await _messageRepository.updateMessageStatus(
              chatId: chatId,
              messageId: msg.messageId,
              status: 'delivered',
            );
          }
        }
      }

      if (messages.isEmpty) {
        emit(const MessageState.empty());
      } else {
        emit(MessageState.loaded(messages));
      }
    });

    on<SendMessage>((event, emit) async {
      final chatId = _currentChatId;
      final currentUserId = _firebaseAuth.currentUser?.uid;
      if (chatId == null || currentUserId == null) return;

      final receiverId = _getReceiverId(chatId, currentUserId);
      if (receiverId.isEmpty) return;

      try {
        await _messageRepository.sendMessage(
          chatId: chatId,
          senderId: currentUserId,
          receiverId: receiverId,
          content: event.content,
        );
      } catch (e) {
        // Yield error status or handle gracefully
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
    return super.close();
  }
}
