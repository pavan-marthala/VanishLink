// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webrtc_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebRtcEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebRtcEventCopyWith<$Res> {
  factory $WebRtcEventCopyWith(
          WebRtcEvent value, $Res Function(WebRtcEvent) then) =
      _$WebRtcEventCopyWithImpl<$Res, WebRtcEvent>;
}

/// @nodoc
class _$WebRtcEventCopyWithImpl<$Res, $Val extends WebRtcEvent>
    implements $WebRtcEventCopyWith<$Res> {
  _$WebRtcEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitializeConnectionImplCopyWith<$Res> {
  factory _$$InitializeConnectionImplCopyWith(_$InitializeConnectionImpl value,
          $Res Function(_$InitializeConnectionImpl) then) =
      __$$InitializeConnectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId, String currentUserId, String peerUserId});
}

/// @nodoc
class __$$InitializeConnectionImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$InitializeConnectionImpl>
    implements _$$InitializeConnectionImplCopyWith<$Res> {
  __$$InitializeConnectionImplCopyWithImpl(_$InitializeConnectionImpl _value,
      $Res Function(_$InitializeConnectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? currentUserId = null,
    Object? peerUserId = null,
  }) {
    return _then(_$InitializeConnectionImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      currentUserId: null == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String,
      peerUserId: null == peerUserId
          ? _value.peerUserId
          : peerUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitializeConnectionImpl implements InitializeConnection {
  const _$InitializeConnectionImpl(
      {required this.sessionId,
      required this.currentUserId,
      required this.peerUserId});

  @override
  final String sessionId;
  @override
  final String currentUserId;
  @override
  final String peerUserId;

  @override
  String toString() {
    return 'WebRtcEvent.initializeConnection(sessionId: $sessionId, currentUserId: $currentUserId, peerUserId: $peerUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializeConnectionImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            (identical(other.peerUserId, peerUserId) ||
                other.peerUserId == peerUserId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, currentUserId, peerUserId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializeConnectionImplCopyWith<_$InitializeConnectionImpl>
      get copyWith =>
          __$$InitializeConnectionImplCopyWithImpl<_$InitializeConnectionImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return initializeConnection(sessionId, currentUserId, peerUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return initializeConnection?.call(sessionId, currentUserId, peerUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (initializeConnection != null) {
      return initializeConnection(sessionId, currentUserId, peerUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return initializeConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return initializeConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (initializeConnection != null) {
      return initializeConnection(this);
    }
    return orElse();
  }
}

abstract class InitializeConnection implements WebRtcEvent {
  const factory InitializeConnection(
      {required final String sessionId,
      required final String currentUserId,
      required final String peerUserId}) = _$InitializeConnectionImpl;

  String get sessionId;
  String get currentUserId;
  String get peerUserId;
  @JsonKey(ignore: true)
  _$$InitializeConnectionImplCopyWith<_$InitializeConnectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateOfferImplCopyWith<$Res> {
  factory _$$CreateOfferImplCopyWith(
          _$CreateOfferImpl value, $Res Function(_$CreateOfferImpl) then) =
      __$$CreateOfferImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateOfferImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$CreateOfferImpl>
    implements _$$CreateOfferImplCopyWith<$Res> {
  __$$CreateOfferImplCopyWithImpl(
      _$CreateOfferImpl _value, $Res Function(_$CreateOfferImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateOfferImpl implements CreateOffer {
  const _$CreateOfferImpl();

  @override
  String toString() {
    return 'WebRtcEvent.createOffer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreateOfferImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return createOffer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return createOffer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (createOffer != null) {
      return createOffer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return createOffer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return createOffer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (createOffer != null) {
      return createOffer(this);
    }
    return orElse();
  }
}

abstract class CreateOffer implements WebRtcEvent {
  const factory CreateOffer() = _$CreateOfferImpl;
}

/// @nodoc
abstract class _$$ReceiveOfferImplCopyWith<$Res> {
  factory _$$ReceiveOfferImplCopyWith(
          _$ReceiveOfferImpl value, $Res Function(_$ReceiveOfferImpl) then) =
      __$$ReceiveOfferImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReceiveOfferImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$ReceiveOfferImpl>
    implements _$$ReceiveOfferImplCopyWith<$Res> {
  __$$ReceiveOfferImplCopyWithImpl(
      _$ReceiveOfferImpl _value, $Res Function(_$ReceiveOfferImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReceiveOfferImpl implements ReceiveOffer {
  const _$ReceiveOfferImpl();

  @override
  String toString() {
    return 'WebRtcEvent.receiveOffer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReceiveOfferImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return receiveOffer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return receiveOffer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (receiveOffer != null) {
      return receiveOffer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return receiveOffer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return receiveOffer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (receiveOffer != null) {
      return receiveOffer(this);
    }
    return orElse();
  }
}

abstract class ReceiveOffer implements WebRtcEvent {
  const factory ReceiveOffer() = _$ReceiveOfferImpl;
}

/// @nodoc
abstract class _$$CreateAnswerImplCopyWith<$Res> {
  factory _$$CreateAnswerImplCopyWith(
          _$CreateAnswerImpl value, $Res Function(_$CreateAnswerImpl) then) =
      __$$CreateAnswerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateAnswerImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$CreateAnswerImpl>
    implements _$$CreateAnswerImplCopyWith<$Res> {
  __$$CreateAnswerImplCopyWithImpl(
      _$CreateAnswerImpl _value, $Res Function(_$CreateAnswerImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateAnswerImpl implements CreateAnswer {
  const _$CreateAnswerImpl();

  @override
  String toString() {
    return 'WebRtcEvent.createAnswer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreateAnswerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return createAnswer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return createAnswer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (createAnswer != null) {
      return createAnswer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return createAnswer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return createAnswer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (createAnswer != null) {
      return createAnswer(this);
    }
    return orElse();
  }
}

abstract class CreateAnswer implements WebRtcEvent {
  const factory CreateAnswer() = _$CreateAnswerImpl;
}

/// @nodoc
abstract class _$$ReceiveAnswerImplCopyWith<$Res> {
  factory _$$ReceiveAnswerImplCopyWith(
          _$ReceiveAnswerImpl value, $Res Function(_$ReceiveAnswerImpl) then) =
      __$$ReceiveAnswerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReceiveAnswerImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$ReceiveAnswerImpl>
    implements _$$ReceiveAnswerImplCopyWith<$Res> {
  __$$ReceiveAnswerImplCopyWithImpl(
      _$ReceiveAnswerImpl _value, $Res Function(_$ReceiveAnswerImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReceiveAnswerImpl implements ReceiveAnswer {
  const _$ReceiveAnswerImpl();

  @override
  String toString() {
    return 'WebRtcEvent.receiveAnswer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReceiveAnswerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return receiveAnswer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return receiveAnswer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (receiveAnswer != null) {
      return receiveAnswer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return receiveAnswer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return receiveAnswer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (receiveAnswer != null) {
      return receiveAnswer(this);
    }
    return orElse();
  }
}

abstract class ReceiveAnswer implements WebRtcEvent {
  const factory ReceiveAnswer() = _$ReceiveAnswerImpl;
}

/// @nodoc
abstract class _$$AddCandidateImplCopyWith<$Res> {
  factory _$$AddCandidateImplCopyWith(
          _$AddCandidateImpl value, $Res Function(_$AddCandidateImpl) then) =
      __$$AddCandidateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddCandidateImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$AddCandidateImpl>
    implements _$$AddCandidateImplCopyWith<$Res> {
  __$$AddCandidateImplCopyWithImpl(
      _$AddCandidateImpl _value, $Res Function(_$AddCandidateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddCandidateImpl implements AddCandidate {
  const _$AddCandidateImpl();

  @override
  String toString() {
    return 'WebRtcEvent.addCandidate()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddCandidateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return addCandidate();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return addCandidate?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (addCandidate != null) {
      return addCandidate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return addCandidate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return addCandidate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (addCandidate != null) {
      return addCandidate(this);
    }
    return orElse();
  }
}

abstract class AddCandidate implements WebRtcEvent {
  const factory AddCandidate() = _$AddCandidateImpl;
}

/// @nodoc
abstract class _$$ConnectionStateChangedImplCopyWith<$Res> {
  factory _$$ConnectionStateChangedImplCopyWith(
          _$ConnectionStateChangedImpl value,
          $Res Function(_$ConnectionStateChangedImpl) then) =
      __$$ConnectionStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String state});
}

/// @nodoc
class __$$ConnectionStateChangedImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$ConnectionStateChangedImpl>
    implements _$$ConnectionStateChangedImplCopyWith<$Res> {
  __$$ConnectionStateChangedImplCopyWithImpl(
      _$ConnectionStateChangedImpl _value,
      $Res Function(_$ConnectionStateChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$ConnectionStateChangedImpl(
      null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionStateChangedImpl implements ConnectionStateChanged {
  const _$ConnectionStateChangedImpl(this.state);

  @override
  final String state;

  @override
  String toString() {
    return 'WebRtcEvent.connectionStateChanged(state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStateChangedImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStateChangedImplCopyWith<_$ConnectionStateChangedImpl>
      get copyWith => __$$ConnectionStateChangedImplCopyWithImpl<
          _$ConnectionStateChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return connectionStateChanged(state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return connectionStateChanged?.call(state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return connectionStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return connectionStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(this);
    }
    return orElse();
  }
}

abstract class ConnectionStateChanged implements WebRtcEvent {
  const factory ConnectionStateChanged(final String state) =
      _$ConnectionStateChangedImpl;

  String get state;
  @JsonKey(ignore: true)
  _$$ConnectionStateChangedImplCopyWith<_$ConnectionStateChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CloseConnectionImplCopyWith<$Res> {
  factory _$$CloseConnectionImplCopyWith(_$CloseConnectionImpl value,
          $Res Function(_$CloseConnectionImpl) then) =
      __$$CloseConnectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CloseConnectionImplCopyWithImpl<$Res>
    extends _$WebRtcEventCopyWithImpl<$Res, _$CloseConnectionImpl>
    implements _$$CloseConnectionImplCopyWith<$Res> {
  __$$CloseConnectionImplCopyWithImpl(
      _$CloseConnectionImpl _value, $Res Function(_$CloseConnectionImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CloseConnectionImpl implements CloseConnection {
  const _$CloseConnectionImpl();

  @override
  String toString() {
    return 'WebRtcEvent.closeConnection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CloseConnectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String sessionId, String currentUserId, String peerUserId)
        initializeConnection,
    required TResult Function() createOffer,
    required TResult Function() receiveOffer,
    required TResult Function() createAnswer,
    required TResult Function() receiveAnswer,
    required TResult Function() addCandidate,
    required TResult Function(String state) connectionStateChanged,
    required TResult Function() closeConnection,
  }) {
    return closeConnection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult? Function()? createOffer,
    TResult? Function()? receiveOffer,
    TResult? Function()? createAnswer,
    TResult? Function()? receiveAnswer,
    TResult? Function()? addCandidate,
    TResult? Function(String state)? connectionStateChanged,
    TResult? Function()? closeConnection,
  }) {
    return closeConnection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String sessionId, String currentUserId, String peerUserId)?
        initializeConnection,
    TResult Function()? createOffer,
    TResult Function()? receiveOffer,
    TResult Function()? createAnswer,
    TResult Function()? receiveAnswer,
    TResult Function()? addCandidate,
    TResult Function(String state)? connectionStateChanged,
    TResult Function()? closeConnection,
    required TResult orElse(),
  }) {
    if (closeConnection != null) {
      return closeConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeConnection value) initializeConnection,
    required TResult Function(CreateOffer value) createOffer,
    required TResult Function(ReceiveOffer value) receiveOffer,
    required TResult Function(CreateAnswer value) createAnswer,
    required TResult Function(ReceiveAnswer value) receiveAnswer,
    required TResult Function(AddCandidate value) addCandidate,
    required TResult Function(ConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(CloseConnection value) closeConnection,
  }) {
    return closeConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeConnection value)? initializeConnection,
    TResult? Function(CreateOffer value)? createOffer,
    TResult? Function(ReceiveOffer value)? receiveOffer,
    TResult? Function(CreateAnswer value)? createAnswer,
    TResult? Function(ReceiveAnswer value)? receiveAnswer,
    TResult? Function(AddCandidate value)? addCandidate,
    TResult? Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult? Function(CloseConnection value)? closeConnection,
  }) {
    return closeConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeConnection value)? initializeConnection,
    TResult Function(CreateOffer value)? createOffer,
    TResult Function(ReceiveOffer value)? receiveOffer,
    TResult Function(CreateAnswer value)? createAnswer,
    TResult Function(ReceiveAnswer value)? receiveAnswer,
    TResult Function(AddCandidate value)? addCandidate,
    TResult Function(ConnectionStateChanged value)? connectionStateChanged,
    TResult Function(CloseConnection value)? closeConnection,
    required TResult orElse(),
  }) {
    if (closeConnection != null) {
      return closeConnection(this);
    }
    return orElse();
  }
}

abstract class CloseConnection implements WebRtcEvent {
  const factory CloseConnection() = _$CloseConnectionImpl;
}
