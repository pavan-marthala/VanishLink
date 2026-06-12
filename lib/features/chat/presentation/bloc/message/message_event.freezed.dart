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
    required TResult Function(String content) sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content)? sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content)? sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MessagesUpdated value)? messagesUpdated,
    TResult? Function(MessageDelivered value)? messageDelivered,
    TResult? Function(MessageRead value)? messageRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MessagesUpdated value)? messagesUpdated,
    TResult Function(MessageDelivered value)? messageDelivered,
    TResult Function(MessageRead value)? messageRead,
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
    required TResult Function(String content) sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
  }) {
    return loadMessages(chatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content)? sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
  }) {
    return loadMessages?.call(chatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content)? sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
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
  $Res call({String content});
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
  }) {
    return _then(_$SendMessageImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendMessageImpl implements SendMessage {
  const _$SendMessageImpl({required this.content});

  @override
  final String content;

  @override
  String toString() {
    return 'MessageEvent.sendMessage(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      __$$SendMessageImplCopyWithImpl<_$SendMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String content) sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
  }) {
    return sendMessage(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content)? sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
  }) {
    return sendMessage?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content)? sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(content);
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
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class SendMessage implements MessageEvent {
  const factory SendMessage({required final String content}) =
      _$SendMessageImpl;

  String get content;
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
    required TResult Function(String content) sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
  }) {
    return messagesUpdated(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content)? sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
  }) {
    return messagesUpdated?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content)? sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
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
    required TResult Function(String content) sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
  }) {
    return messageDelivered(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content)? sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
  }) {
    return messageDelivered?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content)? sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
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
    required TResult Function(String content) sendMessage,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String messageId) messageDelivered,
    required TResult Function(String messageId) messageRead,
  }) {
    return messageRead(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String content)? sendMessage,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String messageId)? messageDelivered,
    TResult? Function(String messageId)? messageRead,
  }) {
    return messageRead?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String content)? sendMessage,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String messageId)? messageDelivered,
    TResult Function(String messageId)? messageRead,
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
