// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEventCopyWith<$Res> {
  factory $MessageEventCopyWith(
          MessageEvent value, $Res Function(MessageEvent) then) =
      _$MessageEventCopyWithImpl<$Res, MessageEvent>;
}

/// @nodoc
class _$MessageEventCopyWithImpl<$Res, $Val extends MessageEvent>
    implements $MessageEventCopyWith<$Res> {
  _$MessageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
          _$LoadMessagesImpl value, $Res Function(_$LoadMessagesImpl) then) =
      __$$LoadMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chatId});
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
      _$LoadMessagesImpl _value, $Res Function(_$LoadMessagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
  }) {
    return _then(_$LoadMessagesImpl(
      null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadMessagesImpl implements LoadMessages {
  const _$LoadMessagesImpl(this.chatId);

  @override
  final String chatId;

  @override
  String toString() {
    return 'MessageEvent.loadMessages(chatId: $chatId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMessagesImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      __$$LoadMessagesImplCopyWithImpl<_$LoadMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return loadMessages(chatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return loadMessages?.call(chatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(chatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class LoadMessages implements MessageEvent {
  const factory LoadMessages(final String chatId) = _$LoadMessagesImpl;

  String get chatId;
  @JsonKey(ignore: true)
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMessageImplCopyWith<$Res> {
  factory _$$SendMessageImplCopyWith(
          _$SendMessageImpl value, $Res Function(_$SendMessageImpl) then) =
      __$$SendMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String content,
      String? replyToMessageId,
      String? replyToSenderId,
      String? replyToPreview});
}

/// @nodoc
class __$$SendMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$SendMessageImpl>
    implements _$$SendMessageImplCopyWith<$Res> {
  __$$SendMessageImplCopyWithImpl(
      _$SendMessageImpl _value, $Res Function(_$SendMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? replyToMessageId = freezed,
    Object? replyToSenderId = freezed,
    Object? replyToPreview = freezed,
  }) {
    return _then(_$SendMessageImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      replyToMessageId: freezed == replyToMessageId
          ? _value.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToSenderId: freezed == replyToSenderId
          ? _value.replyToSenderId
          : replyToSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToPreview: freezed == replyToPreview
          ? _value.replyToPreview
          : replyToPreview // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SendMessageImpl implements SendMessage {
  const _$SendMessageImpl(
      {required this.content,
      this.replyToMessageId,
      this.replyToSenderId,
      this.replyToPreview});

  @override
  final String content;
  @override
  final String? replyToMessageId;
  @override
  final String? replyToSenderId;
  @override
  final String? replyToPreview;

  @override
  String toString() {
    return 'MessageEvent.sendMessage(content: $content, replyToMessageId: $replyToMessageId, replyToSenderId: $replyToSenderId, replyToPreview: $replyToPreview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.replyToSenderId, replyToSenderId) ||
                other.replyToSenderId == replyToSenderId) &&
            (identical(other.replyToPreview, replyToPreview) ||
                other.replyToPreview == replyToPreview));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, content, replyToMessageId, replyToSenderId, replyToPreview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      __$$SendMessageImplCopyWithImpl<_$SendMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return sendMessage(
        content, replyToMessageId, replyToSenderId, replyToPreview);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return sendMessage?.call(
        content, replyToMessageId, replyToSenderId, replyToPreview);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(
          content, replyToMessageId, replyToSenderId, replyToPreview);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class SendMessage implements MessageEvent {
  const factory SendMessage(
      {required final String content,
      final String? replyToMessageId,
      final String? replyToSenderId,
      final String? replyToPreview}) = _$SendMessageImpl;

  String get content;
  String? get replyToMessageId;
  String? get replyToSenderId;
  String? get replyToPreview;
  @JsonKey(ignore: true)
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessagesUpdatedImplCopyWith<$Res> {
  factory _$$MessagesUpdatedImplCopyWith(_$MessagesUpdatedImpl value,
          $Res Function(_$MessagesUpdatedImpl) then) =
      __$$MessagesUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Message> messages});
}

/// @nodoc
class __$$MessagesUpdatedImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$MessagesUpdatedImpl>
    implements _$$MessagesUpdatedImplCopyWith<$Res> {
  __$$MessagesUpdatedImplCopyWithImpl(
      _$MessagesUpdatedImpl _value, $Res Function(_$MessagesUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$MessagesUpdatedImpl(
      null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc

class _$MessagesUpdatedImpl implements MessagesUpdated {
  const _$MessagesUpdatedImpl(final List<Message> messages)
      : _messages = messages;

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'MessageEvent.messagesUpdated(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesUpdatedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesUpdatedImplCopyWith<_$MessagesUpdatedImpl> get copyWith =>
      __$$MessagesUpdatedImplCopyWithImpl<_$MessagesUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return messagesUpdated(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return messagesUpdated?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return messagesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return messagesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(this);
    }
    return orElse();
  }
}

abstract class MessagesUpdated implements MessageEvent {
  const factory MessagesUpdated(final List<Message> messages) =
      _$MessagesUpdatedImpl;

  List<Message> get messages;
  @JsonKey(ignore: true)
  _$$MessagesUpdatedImplCopyWith<_$MessagesUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageDeliveredImplCopyWith<$Res> {
  factory _$$MessageDeliveredImplCopyWith(_$MessageDeliveredImpl value,
          $Res Function(_$MessageDeliveredImpl) then) =
      __$$MessageDeliveredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId});
}

/// @nodoc
class __$$MessageDeliveredImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$MessageDeliveredImpl>
    implements _$$MessageDeliveredImplCopyWith<$Res> {
  __$$MessageDeliveredImplCopyWithImpl(_$MessageDeliveredImpl _value,
      $Res Function(_$MessageDeliveredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_$MessageDeliveredImpl(
      null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageDeliveredImpl implements MessageDelivered {
  const _$MessageDeliveredImpl(this.messageId);

  @override
  final String messageId;

  @override
  String toString() {
    return 'MessageEvent.messageDelivered(messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageDeliveredImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageDeliveredImplCopyWith<_$MessageDeliveredImpl> get copyWith =>
      __$$MessageDeliveredImplCopyWithImpl<_$MessageDeliveredImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return messageDelivered(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return messageDelivered?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (messageDelivered != null) {
      return messageDelivered(messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return messageDelivered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return messageDelivered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (messageDelivered != null) {
      return messageDelivered(this);
    }
    return orElse();
  }
}

abstract class MessageDelivered implements MessageEvent {
  const factory MessageDelivered(final String messageId) =
      _$MessageDeliveredImpl;

  String get messageId;
  @JsonKey(ignore: true)
  _$$MessageDeliveredImplCopyWith<_$MessageDeliveredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageReadImplCopyWith<$Res> {
  factory _$$MessageReadImplCopyWith(
          _$MessageReadImpl value, $Res Function(_$MessageReadImpl) then) =
      __$$MessageReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId});
}

/// @nodoc
class __$$MessageReadImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$MessageReadImpl>
    implements _$$MessageReadImplCopyWith<$Res> {
  __$$MessageReadImplCopyWithImpl(
      _$MessageReadImpl _value, $Res Function(_$MessageReadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_$MessageReadImpl(
      null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageReadImpl implements MessageRead {
  const _$MessageReadImpl(this.messageId);

  @override
  final String messageId;

  @override
  String toString() {
    return 'MessageEvent.messageRead(messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageReadImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageReadImplCopyWith<_$MessageReadImpl> get copyWith =>
      __$$MessageReadImplCopyWithImpl<_$MessageReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return messageRead(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return messageRead?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (messageRead != null) {
      return messageRead(messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return messageRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return messageRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (messageRead != null) {
      return messageRead(this);
    }
    return orElse();
  }
}

abstract class MessageRead implements MessageEvent {
  const factory MessageRead(final String messageId) = _$MessageReadImpl;

  String get messageId;
  @JsonKey(ignore: true)
  _$$MessageReadImplCopyWith<_$MessageReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
          _$MarkAsReadImpl value, $Res Function(_$MarkAsReadImpl) then) =
      __$$MarkAsReadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
      _$MarkAsReadImpl _value, $Res Function(_$MarkAsReadImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MarkAsReadImpl implements MarkAsRead {
  const _$MarkAsReadImpl();

  @override
  String toString() {
    return 'MessageEvent.markAsRead()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MarkAsReadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return markAsRead();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return markAsRead?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class MarkAsRead implements MessageEvent {
  const factory MarkAsRead() = _$MarkAsReadImpl;
}

/// @nodoc
abstract class _$$RetryMessageImplCopyWith<$Res> {
  factory _$$RetryMessageImplCopyWith(
          _$RetryMessageImpl value, $Res Function(_$RetryMessageImpl) then) =
      __$$RetryMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Message message});
}

/// @nodoc
class __$$RetryMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$RetryMessageImpl>
    implements _$$RetryMessageImplCopyWith<$Res> {
  __$$RetryMessageImplCopyWithImpl(
      _$RetryMessageImpl _value, $Res Function(_$RetryMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RetryMessageImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }
}

/// @nodoc

class _$RetryMessageImpl implements RetryMessage {
  const _$RetryMessageImpl(this.message);

  @override
  final Message message;

  @override
  String toString() {
    return 'MessageEvent.retryMessage(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RetryMessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RetryMessageImplCopyWith<_$RetryMessageImpl> get copyWith =>
      __$$RetryMessageImplCopyWithImpl<_$RetryMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return retryMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return retryMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (retryMessage != null) {
      return retryMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return retryMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return retryMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (retryMessage != null) {
      return retryMessage(this);
    }
    return orElse();
  }
}

abstract class RetryMessage implements MessageEvent {
  const factory RetryMessage(final Message message) = _$RetryMessageImpl;

  Message get message;
  @JsonKey(ignore: true)
  _$$RetryMessageImplCopyWith<_$RetryMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditMessageImplCopyWith<$Res> {
  factory _$$EditMessageImplCopyWith(
          _$EditMessageImpl value, $Res Function(_$EditMessageImpl) then) =
      __$$EditMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String newContent});
}

/// @nodoc
class __$$EditMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$EditMessageImpl>
    implements _$$EditMessageImplCopyWith<$Res> {
  __$$EditMessageImplCopyWithImpl(
      _$EditMessageImpl _value, $Res Function(_$EditMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? newContent = null,
  }) {
    return _then(_$EditMessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      newContent: null == newContent
          ? _value.newContent
          : newContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditMessageImpl implements EditMessage {
  const _$EditMessageImpl({required this.messageId, required this.newContent});

  @override
  final String messageId;
  @override
  final String newContent;

  @override
  String toString() {
    return 'MessageEvent.editMessage(messageId: $messageId, newContent: $newContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.newContent, newContent) ||
                other.newContent == newContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, newContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMessageImplCopyWith<_$EditMessageImpl> get copyWith =>
      __$$EditMessageImplCopyWithImpl<_$EditMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return editMessage(messageId, newContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return editMessage?.call(messageId, newContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (editMessage != null) {
      return editMessage(messageId, newContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return editMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return editMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (editMessage != null) {
      return editMessage(this);
    }
    return orElse();
  }
}

abstract class EditMessage implements MessageEvent {
  const factory EditMessage(
      {required final String messageId,
      required final String newContent}) = _$EditMessageImpl;

  String get messageId;
  String get newContent;
  @JsonKey(ignore: true)
  _$$EditMessageImplCopyWith<_$EditMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMessageImplCopyWith<$Res> {
  factory _$$DeleteMessageImplCopyWith(
          _$DeleteMessageImpl value, $Res Function(_$DeleteMessageImpl) then) =
      __$$DeleteMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, bool forEveryone});
}

/// @nodoc
class __$$DeleteMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$DeleteMessageImpl>
    implements _$$DeleteMessageImplCopyWith<$Res> {
  __$$DeleteMessageImplCopyWithImpl(
      _$DeleteMessageImpl _value, $Res Function(_$DeleteMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? forEveryone = null,
  }) {
    return _then(_$DeleteMessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      forEveryone: null == forEveryone
          ? _value.forEveryone
          : forEveryone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DeleteMessageImpl implements DeleteMessage {
  const _$DeleteMessageImpl(
      {required this.messageId, required this.forEveryone});

  @override
  final String messageId;
  @override
  final bool forEveryone;

  @override
  String toString() {
    return 'MessageEvent.deleteMessage(messageId: $messageId, forEveryone: $forEveryone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.forEveryone, forEveryone) ||
                other.forEveryone == forEveryone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, forEveryone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMessageImplCopyWith<_$DeleteMessageImpl> get copyWith =>
      __$$DeleteMessageImplCopyWithImpl<_$DeleteMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return deleteMessage(messageId, forEveryone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return deleteMessage?.call(messageId, forEveryone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(messageId, forEveryone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return deleteMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return deleteMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(this);
    }
    return orElse();
  }
}

abstract class DeleteMessage implements MessageEvent {
  const factory DeleteMessage(
      {required final String messageId,
      required final bool forEveryone}) = _$DeleteMessageImpl;

  String get messageId;
  bool get forEveryone;
  @JsonKey(ignore: true)
  _$$DeleteMessageImplCopyWith<_$DeleteMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateReactionImplCopyWith<$Res> {
  factory _$$UpdateReactionImplCopyWith(_$UpdateReactionImpl value,
          $Res Function(_$UpdateReactionImpl) then) =
      __$$UpdateReactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String? reaction});
}

/// @nodoc
class __$$UpdateReactionImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$UpdateReactionImpl>
    implements _$$UpdateReactionImplCopyWith<$Res> {
  __$$UpdateReactionImplCopyWithImpl(
      _$UpdateReactionImpl _value, $Res Function(_$UpdateReactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? reaction = freezed,
  }) {
    return _then(_$UpdateReactionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      reaction: freezed == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UpdateReactionImpl implements UpdateReaction {
  const _$UpdateReactionImpl({required this.messageId, required this.reaction});

  @override
  final String messageId;
  @override
  final String? reaction;

  @override
  String toString() {
    return 'MessageEvent.updateReaction(messageId: $messageId, reaction: $reaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateReactionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, reaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateReactionImplCopyWith<_$UpdateReactionImpl> get copyWith =>
      __$$UpdateReactionImplCopyWithImpl<_$UpdateReactionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return updateReaction(messageId, reaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return updateReaction?.call(messageId, reaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (updateReaction != null) {
      return updateReaction(messageId, reaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return updateReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return updateReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (updateReaction != null) {
      return updateReaction(this);
    }
    return orElse();
  }
}

abstract class UpdateReaction implements MessageEvent {
  const factory UpdateReaction(
      {required final String messageId,
      required final String? reaction}) = _$UpdateReactionImpl;

  String get messageId;
  String? get reaction;
  @JsonKey(ignore: true)
  _$$UpdateReactionImplCopyWith<_$UpdateReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetTypingImplCopyWith<$Res> {
  factory _$$SetTypingImplCopyWith(
          _$SetTypingImpl value, $Res Function(_$SetTypingImpl) then) =
      __$$SetTypingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isTyping});
}

/// @nodoc
class __$$SetTypingImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$SetTypingImpl>
    implements _$$SetTypingImplCopyWith<$Res> {
  __$$SetTypingImplCopyWithImpl(
      _$SetTypingImpl _value, $Res Function(_$SetTypingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTyping = null,
  }) {
    return _then(_$SetTypingImpl(
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SetTypingImpl implements SetTyping {
  const _$SetTypingImpl({required this.isTyping});

  @override
  final bool isTyping;

  @override
  String toString() {
    return 'MessageEvent.setTyping(isTyping: $isTyping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetTypingImpl &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isTyping);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetTypingImplCopyWith<_$SetTypingImpl> get copyWith =>
      __$$SetTypingImplCopyWithImpl<_$SetTypingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return setTyping(isTyping);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return setTyping?.call(isTyping);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (setTyping != null) {
      return setTyping(isTyping);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return setTyping(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return setTyping?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (setTyping != null) {
      return setTyping(this);
    }
    return orElse();
  }
}

abstract class SetTyping implements MessageEvent {
  const factory SetTyping({required final bool isTyping}) = _$SetTypingImpl;

  bool get isTyping;
  @JsonKey(ignore: true)
  _$$SetTypingImplCopyWith<_$SetTypingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TypingUsersUpdatedImplCopyWith<$Res> {
  factory _$$TypingUsersUpdatedImplCopyWith(_$TypingUsersUpdatedImpl value,
          $Res Function(_$TypingUsersUpdatedImpl) then) =
      __$$TypingUsersUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> typingUsers});
}

/// @nodoc
class __$$TypingUsersUpdatedImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$TypingUsersUpdatedImpl>
    implements _$$TypingUsersUpdatedImplCopyWith<$Res> {
  __$$TypingUsersUpdatedImplCopyWithImpl(_$TypingUsersUpdatedImpl _value,
      $Res Function(_$TypingUsersUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typingUsers = null,
  }) {
    return _then(_$TypingUsersUpdatedImpl(
      null == typingUsers
          ? _value._typingUsers
          : typingUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$TypingUsersUpdatedImpl implements TypingUsersUpdated {
  const _$TypingUsersUpdatedImpl(final List<String> typingUsers)
      : _typingUsers = typingUsers;

  final List<String> _typingUsers;
  @override
  List<String> get typingUsers {
    if (_typingUsers is EqualUnmodifiableListView) return _typingUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typingUsers);
  }

  @override
  String toString() {
    return 'MessageEvent.typingUsersUpdated(typingUsers: $typingUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypingUsersUpdatedImpl &&
            const DeepCollectionEquality()
                .equals(other._typingUsers, _typingUsers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_typingUsers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TypingUsersUpdatedImplCopyWith<_$TypingUsersUpdatedImpl> get copyWith =>
      __$$TypingUsersUpdatedImplCopyWithImpl<_$TypingUsersUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)
        sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
    required TResult Function() markAsRead,
    required TResult Function(Message message) retryMessage,
    required TResult Function(String messageId, String newContent) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(String messageId, String? reaction)
        updateReaction,
    required TResult Function(bool isTyping) setTyping,
    required TResult Function(List<String> typingUsers) typingUsersUpdated,
  }) {
    return typingUsersUpdated(typingUsers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
    TResult? Function()? markAsRead,
    TResult? Function(Message message)? retryMessage,
    TResult? Function(String messageId, String newContent)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(String messageId, String? reaction)? updateReaction,
    TResult? Function(bool isTyping)? setTyping,
    TResult? Function(List<String> typingUsers)? typingUsersUpdated,
  }) {
    return typingUsersUpdated?.call(typingUsers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content, String? replyToMessageId,
            String? replyToSenderId, String? replyToPreview)?
        sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    TResult Function()? markAsRead,
    TResult Function(Message message)? retryMessage,
    TResult Function(String messageId, String newContent)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(String messageId, String? reaction)? updateReaction,
    TResult Function(bool isTyping)? setTyping,
    TResult Function(List<String> typingUsers)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (typingUsersUpdated != null) {
      return typingUsersUpdated(typingUsers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MessagesUpdated value) messagesUpdated,
    required TResult Function(MessageDelivered value) messageDelivered,
    required TResult Function(MessageRead value) messageRead,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RetryMessage value) retryMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(UpdateReaction value) updateReaction,
    required TResult Function(SetTyping value) setTyping,
    required TResult Function(TypingUsersUpdated value) typingUsersUpdated,
  }) {
    return typingUsersUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RetryMessage value)? retryMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(UpdateReaction value)? updateReaction,
    TResult? Function(SetTyping value)? setTyping,
    TResult? Function(TypingUsersUpdated value)? typingUsersUpdated,
  }) {
    return typingUsersUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RetryMessage value)? retryMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(UpdateReaction value)? updateReaction,
    TResult Function(SetTyping value)? setTyping,
    TResult Function(TypingUsersUpdated value)? typingUsersUpdated,
    required TResult orElse(),
  }) {
    if (typingUsersUpdated != null) {
      return typingUsersUpdated(this);
    }
    return orElse();
  }
}

abstract class TypingUsersUpdated implements MessageEvent {
  const factory TypingUsersUpdated(final List<String> typingUsers) =
      _$TypingUsersUpdatedImpl;

  List<String> get typingUsers;
  @JsonKey(ignore: true)
  _$$TypingUsersUpdatedImplCopyWith<_$TypingUsersUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
