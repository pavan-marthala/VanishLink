// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webrtc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebRtcState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebRtcStateCopyWith<$Res> {
  factory $WebRtcStateCopyWith(
          WebRtcState value, $Res Function(WebRtcState) then) =
      _$WebRtcStateCopyWithImpl<$Res, WebRtcState>;
}

/// @nodoc
class _$WebRtcStateCopyWithImpl<$Res, $Val extends WebRtcState>
    implements $WebRtcStateCopyWith<$Res> {
  _$WebRtcStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$WebRtcStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'WebRtcState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements WebRtcState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$ConnectingImplCopyWith<$Res> {
  factory _$$ConnectingImplCopyWith(
          _$ConnectingImpl value, $Res Function(_$ConnectingImpl) then) =
      __$$ConnectingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String sessionId,
      String connectionState,
      int candidateCount,
      bool offerCreated,
      bool answerReceived});
}

/// @nodoc
class __$$ConnectingImplCopyWithImpl<$Res>
    extends _$WebRtcStateCopyWithImpl<$Res, _$ConnectingImpl>
    implements _$$ConnectingImplCopyWith<$Res> {
  __$$ConnectingImplCopyWithImpl(
      _$ConnectingImpl _value, $Res Function(_$ConnectingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? connectionState = null,
    Object? candidateCount = null,
    Object? offerCreated = null,
    Object? answerReceived = null,
  }) {
    return _then(_$ConnectingImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      connectionState: null == connectionState
          ? _value.connectionState
          : connectionState // ignore: cast_nullable_to_non_nullable
              as String,
      candidateCount: null == candidateCount
          ? _value.candidateCount
          : candidateCount // ignore: cast_nullable_to_non_nullable
              as int,
      offerCreated: null == offerCreated
          ? _value.offerCreated
          : offerCreated // ignore: cast_nullable_to_non_nullable
              as bool,
      answerReceived: null == answerReceived
          ? _value.answerReceived
          : answerReceived // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ConnectingImpl implements Connecting {
  const _$ConnectingImpl(
      {required this.sessionId,
      required this.connectionState,
      required this.candidateCount,
      required this.offerCreated,
      required this.answerReceived});

  @override
  final String sessionId;
  @override
  final String connectionState;
  @override
  final int candidateCount;
  @override
  final bool offerCreated;
  @override
  final bool answerReceived;

  @override
  String toString() {
    return 'WebRtcState.connecting(sessionId: $sessionId, connectionState: $connectionState, candidateCount: $candidateCount, offerCreated: $offerCreated, answerReceived: $answerReceived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectingImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.connectionState, connectionState) ||
                other.connectionState == connectionState) &&
            (identical(other.candidateCount, candidateCount) ||
                other.candidateCount == candidateCount) &&
            (identical(other.offerCreated, offerCreated) ||
                other.offerCreated == offerCreated) &&
            (identical(other.answerReceived, answerReceived) ||
                other.answerReceived == answerReceived));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId, connectionState,
      candidateCount, offerCreated, answerReceived);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectingImplCopyWith<_$ConnectingImpl> get copyWith =>
      __$$ConnectingImplCopyWithImpl<_$ConnectingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) {
    return connecting(sessionId, connectionState, candidateCount, offerCreated,
        answerReceived);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) {
    return connecting?.call(sessionId, connectionState, candidateCount,
        offerCreated, answerReceived);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(sessionId, connectionState, candidateCount,
          offerCreated, answerReceived);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }
}

abstract class Connecting implements WebRtcState {
  const factory Connecting(
      {required final String sessionId,
      required final String connectionState,
      required final int candidateCount,
      required final bool offerCreated,
      required final bool answerReceived}) = _$ConnectingImpl;

  String get sessionId;
  String get connectionState;
  int get candidateCount;
  bool get offerCreated;
  bool get answerReceived;
  @JsonKey(ignore: true)
  _$$ConnectingImplCopyWith<_$ConnectingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectedImplCopyWith<$Res> {
  factory _$$ConnectedImplCopyWith(
          _$ConnectedImpl value, $Res Function(_$ConnectedImpl) then) =
      __$$ConnectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId, int candidateCount});
}

/// @nodoc
class __$$ConnectedImplCopyWithImpl<$Res>
    extends _$WebRtcStateCopyWithImpl<$Res, _$ConnectedImpl>
    implements _$$ConnectedImplCopyWith<$Res> {
  __$$ConnectedImplCopyWithImpl(
      _$ConnectedImpl _value, $Res Function(_$ConnectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? candidateCount = null,
  }) {
    return _then(_$ConnectedImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      candidateCount: null == candidateCount
          ? _value.candidateCount
          : candidateCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ConnectedImpl implements Connected {
  const _$ConnectedImpl(
      {required this.sessionId, required this.candidateCount});

  @override
  final String sessionId;
  @override
  final int candidateCount;

  @override
  String toString() {
    return 'WebRtcState.connected(sessionId: $sessionId, candidateCount: $candidateCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.candidateCount, candidateCount) ||
                other.candidateCount == candidateCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId, candidateCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      __$$ConnectedImplCopyWithImpl<_$ConnectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) {
    return connected(sessionId, candidateCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) {
    return connected?.call(sessionId, candidateCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(sessionId, candidateCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected implements WebRtcState {
  const factory Connected(
      {required final String sessionId,
      required final int candidateCount}) = _$ConnectedImpl;

  String get sessionId;
  int get candidateCount;
  @JsonKey(ignore: true)
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DisconnectedImplCopyWith<$Res> {
  factory _$$DisconnectedImplCopyWith(
          _$DisconnectedImpl value, $Res Function(_$DisconnectedImpl) then) =
      __$$DisconnectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$DisconnectedImplCopyWithImpl<$Res>
    extends _$WebRtcStateCopyWithImpl<$Res, _$DisconnectedImpl>
    implements _$$DisconnectedImplCopyWith<$Res> {
  __$$DisconnectedImplCopyWithImpl(
      _$DisconnectedImpl _value, $Res Function(_$DisconnectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
  }) {
    return _then(_$DisconnectedImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DisconnectedImpl implements Disconnected {
  const _$DisconnectedImpl({required this.sessionId});

  @override
  final String sessionId;

  @override
  String toString() {
    return 'WebRtcState.disconnected(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectedImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DisconnectedImplCopyWith<_$DisconnectedImpl> get copyWith =>
      __$$DisconnectedImplCopyWithImpl<_$DisconnectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) {
    return disconnected(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) {
    return disconnected?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class Disconnected implements WebRtcState {
  const factory Disconnected({required final String sessionId}) =
      _$DisconnectedImpl;

  String get sessionId;
  @JsonKey(ignore: true)
  _$$DisconnectedImplCopyWith<_$DisconnectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId, String error});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$WebRtcStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? error = null,
  }) {
    return _then(_$FailedImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements Failed {
  const _$FailedImpl({required this.sessionId, required this.error});

  @override
  final String sessionId;
  @override
  final String error;

  @override
  String toString() {
    return 'WebRtcState.failed(sessionId: $sessionId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) {
    return failed(sessionId, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) {
    return failed?.call(sessionId, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(sessionId, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class Failed implements WebRtcState {
  const factory Failed(
      {required final String sessionId,
      required final String error}) = _$FailedImpl;

  String get sessionId;
  String get error;
  @JsonKey(ignore: true)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClosedImplCopyWith<$Res> {
  factory _$$ClosedImplCopyWith(
          _$ClosedImpl value, $Res Function(_$ClosedImpl) then) =
      __$$ClosedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClosedImplCopyWithImpl<$Res>
    extends _$WebRtcStateCopyWithImpl<$Res, _$ClosedImpl>
    implements _$$ClosedImplCopyWith<$Res> {
  __$$ClosedImplCopyWithImpl(
      _$ClosedImpl _value, $Res Function(_$ClosedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClosedImpl implements Closed {
  const _$ClosedImpl();

  @override
  String toString() {
    return 'WebRtcState.closed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClosedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)
        connecting,
    required TResult Function(String sessionId, int candidateCount) connected,
    required TResult Function(String sessionId) disconnected,
    required TResult Function(String sessionId, String error) failed,
    required TResult Function() closed,
  }) {
    return closed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult? Function(String sessionId, int candidateCount)? connected,
    TResult? Function(String sessionId)? disconnected,
    TResult? Function(String sessionId, String error)? failed,
    TResult? Function()? closed,
  }) {
    return closed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String sessionId, String connectionState,
            int candidateCount, bool offerCreated, bool answerReceived)?
        connecting,
    TResult Function(String sessionId, int candidateCount)? connected,
    TResult Function(String sessionId)? disconnected,
    TResult Function(String sessionId, String error)? failed,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (closed != null) {
      return closed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Failed value) failed,
    required TResult Function(Closed value) closed,
  }) {
    return closed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Failed value)? failed,
    TResult? Function(Closed value)? closed,
  }) {
    return closed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Failed value)? failed,
    TResult Function(Closed value)? closed,
    required TResult orElse(),
  }) {
    if (closed != null) {
      return closed(this);
    }
    return orElse();
  }
}

abstract class Closed implements WebRtcState {
  const factory Closed() = _$ClosedImpl;
}
