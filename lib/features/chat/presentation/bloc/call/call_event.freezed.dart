// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEventCopyWith<$Res> {
  factory $CallEventCopyWith(CallEvent value, $Res Function(CallEvent) then) =
      _$CallEventCopyWithImpl<$Res, CallEvent>;
}

/// @nodoc
class _$CallEventCopyWithImpl<$Res, $Val extends CallEvent>
    implements $CallEventCopyWith<$Res> {
  _$CallEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateCallImplCopyWith<$Res> {
  factory _$$CreateCallImplCopyWith(
          _$CreateCallImpl value, $Res Function(_$CreateCallImpl) then) =
      __$$CreateCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String callerId, String receiverId, String type});
}

/// @nodoc
class __$$CreateCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CreateCallImpl>
    implements _$$CreateCallImplCopyWith<$Res> {
  __$$CreateCallImplCopyWithImpl(
      _$CreateCallImpl _value, $Res Function(_$CreateCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callerId = null,
    Object? receiverId = null,
    Object? type = null,
  }) {
    return _then(_$CreateCallImpl(
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateCallImpl implements CreateCall {
  const _$CreateCallImpl(
      {required this.callerId, required this.receiverId, required this.type});

  @override
  final String callerId;
  @override
  final String receiverId;
  @override
  final String type;

  @override
  String toString() {
    return 'CallEvent.createCall(callerId: $callerId, receiverId: $receiverId, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCallImpl &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callerId, receiverId, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCallImplCopyWith<_$CreateCallImpl> get copyWith =>
      __$$CreateCallImplCopyWithImpl<_$CreateCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return createCall(callerId, receiverId, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return createCall?.call(callerId, receiverId, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (createCall != null) {
      return createCall(callerId, receiverId, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return createCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return createCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (createCall != null) {
      return createCall(this);
    }
    return orElse();
  }
}

abstract class CreateCall implements CallEvent {
  const factory CreateCall(
      {required final String callerId,
      required final String receiverId,
      required final String type}) = _$CreateCallImpl;

  String get callerId;
  String get receiverId;
  String get type;
  @JsonKey(ignore: true)
  _$$CreateCallImplCopyWith<_$CreateCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptCallImplCopyWith<$Res> {
  factory _$$AcceptCallImplCopyWith(
          _$AcceptCallImpl value, $Res Function(_$AcceptCallImpl) then) =
      __$$AcceptCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AcceptCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$AcceptCallImpl>
    implements _$$AcceptCallImplCopyWith<$Res> {
  __$$AcceptCallImplCopyWithImpl(
      _$AcceptCallImpl _value, $Res Function(_$AcceptCallImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AcceptCallImpl implements AcceptCall {
  const _$AcceptCallImpl();

  @override
  String toString() {
    return 'CallEvent.acceptCall()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AcceptCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return acceptCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return acceptCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (acceptCall != null) {
      return acceptCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return acceptCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return acceptCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (acceptCall != null) {
      return acceptCall(this);
    }
    return orElse();
  }
}

abstract class AcceptCall implements CallEvent {
  const factory AcceptCall() = _$AcceptCallImpl;
}

/// @nodoc
abstract class _$$DeclineCallImplCopyWith<$Res> {
  factory _$$DeclineCallImplCopyWith(
          _$DeclineCallImpl value, $Res Function(_$DeclineCallImpl) then) =
      __$$DeclineCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeclineCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$DeclineCallImpl>
    implements _$$DeclineCallImplCopyWith<$Res> {
  __$$DeclineCallImplCopyWithImpl(
      _$DeclineCallImpl _value, $Res Function(_$DeclineCallImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeclineCallImpl implements DeclineCall {
  const _$DeclineCallImpl();

  @override
  String toString() {
    return 'CallEvent.declineCall()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeclineCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return declineCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return declineCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (declineCall != null) {
      return declineCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return declineCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return declineCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (declineCall != null) {
      return declineCall(this);
    }
    return orElse();
  }
}

abstract class DeclineCall implements CallEvent {
  const factory DeclineCall() = _$DeclineCallImpl;
}

/// @nodoc
abstract class _$$CancelCallImplCopyWith<$Res> {
  factory _$$CancelCallImplCopyWith(
          _$CancelCallImpl value, $Res Function(_$CancelCallImpl) then) =
      __$$CancelCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CancelCallImpl>
    implements _$$CancelCallImplCopyWith<$Res> {
  __$$CancelCallImplCopyWithImpl(
      _$CancelCallImpl _value, $Res Function(_$CancelCallImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CancelCallImpl implements CancelCall {
  const _$CancelCallImpl();

  @override
  String toString() {
    return 'CallEvent.cancelCall()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return cancelCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return cancelCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (cancelCall != null) {
      return cancelCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return cancelCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return cancelCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (cancelCall != null) {
      return cancelCall(this);
    }
    return orElse();
  }
}

abstract class CancelCall implements CallEvent {
  const factory CancelCall() = _$CancelCallImpl;
}

/// @nodoc
abstract class _$$EndCallImplCopyWith<$Res> {
  factory _$$EndCallImplCopyWith(
          _$EndCallImpl value, $Res Function(_$EndCallImpl) then) =
      __$$EndCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EndCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$EndCallImpl>
    implements _$$EndCallImplCopyWith<$Res> {
  __$$EndCallImplCopyWithImpl(
      _$EndCallImpl _value, $Res Function(_$EndCallImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EndCallImpl implements EndCall {
  const _$EndCallImpl();

  @override
  String toString() {
    return 'CallEvent.endCall()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EndCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return endCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return endCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (endCall != null) {
      return endCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return endCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return endCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (endCall != null) {
      return endCall(this);
    }
    return orElse();
  }
}

abstract class EndCall implements CallEvent {
  const factory EndCall() = _$EndCallImpl;
}

/// @nodoc
abstract class _$$ListenToCallImplCopyWith<$Res> {
  factory _$$ListenToCallImplCopyWith(
          _$ListenToCallImpl value, $Res Function(_$ListenToCallImpl) then) =
      __$$ListenToCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String callId});
}

/// @nodoc
class __$$ListenToCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ListenToCallImpl>
    implements _$$ListenToCallImplCopyWith<$Res> {
  __$$ListenToCallImplCopyWithImpl(
      _$ListenToCallImpl _value, $Res Function(_$ListenToCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
  }) {
    return _then(_$ListenToCallImpl(
      null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ListenToCallImpl implements ListenToCall {
  const _$ListenToCallImpl(this.callId);

  @override
  final String callId;

  @override
  String toString() {
    return 'CallEvent.listenToCall(callId: $callId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListenToCallImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListenToCallImplCopyWith<_$ListenToCallImpl> get copyWith =>
      __$$ListenToCallImplCopyWithImpl<_$ListenToCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return listenToCall(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return listenToCall?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (listenToCall != null) {
      return listenToCall(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return listenToCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return listenToCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (listenToCall != null) {
      return listenToCall(this);
    }
    return orElse();
  }
}

abstract class ListenToCall implements CallEvent {
  const factory ListenToCall(final String callId) = _$ListenToCallImpl;

  String get callId;
  @JsonKey(ignore: true)
  _$$ListenToCallImplCopyWith<_$ListenToCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallUpdatedImplCopyWith<$Res> {
  factory _$$CallUpdatedImplCopyWith(
          _$CallUpdatedImpl value, $Res Function(_$CallUpdatedImpl) then) =
      __$$CallUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CallModel? callModel});

  $CallModelCopyWith<$Res>? get callModel;
}

/// @nodoc
class __$$CallUpdatedImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CallUpdatedImpl>
    implements _$$CallUpdatedImplCopyWith<$Res> {
  __$$CallUpdatedImplCopyWithImpl(
      _$CallUpdatedImpl _value, $Res Function(_$CallUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callModel = freezed,
  }) {
    return _then(_$CallUpdatedImpl(
      freezed == callModel
          ? _value.callModel
          : callModel // ignore: cast_nullable_to_non_nullable
              as CallModel?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CallModelCopyWith<$Res>? get callModel {
    if (_value.callModel == null) {
      return null;
    }

    return $CallModelCopyWith<$Res>(_value.callModel!, (value) {
      return _then(_value.copyWith(callModel: value));
    });
  }
}

/// @nodoc

class _$CallUpdatedImpl implements CallUpdated {
  const _$CallUpdatedImpl(this.callModel);

  @override
  final CallModel? callModel;

  @override
  String toString() {
    return 'CallEvent.callUpdated(callModel: $callModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallUpdatedImpl &&
            (identical(other.callModel, callModel) ||
                other.callModel == callModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallUpdatedImplCopyWith<_$CallUpdatedImpl> get copyWith =>
      __$$CallUpdatedImplCopyWithImpl<_$CallUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callerId, String receiverId, String type)
        createCall,
    required TResult Function() acceptCall,
    required TResult Function() declineCall,
    required TResult Function() cancelCall,
    required TResult Function() endCall,
    required TResult Function(String callId) listenToCall,
    required TResult Function(CallModel? callModel) callUpdated,
  }) {
    return callUpdated(callModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callerId, String receiverId, String type)?
        createCall,
    TResult? Function()? acceptCall,
    TResult? Function()? declineCall,
    TResult? Function()? cancelCall,
    TResult? Function()? endCall,
    TResult? Function(String callId)? listenToCall,
    TResult? Function(CallModel? callModel)? callUpdated,
  }) {
    return callUpdated?.call(callModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callerId, String receiverId, String type)?
        createCall,
    TResult Function()? acceptCall,
    TResult Function()? declineCall,
    TResult Function()? cancelCall,
    TResult Function()? endCall,
    TResult Function(String callId)? listenToCall,
    TResult Function(CallModel? callModel)? callUpdated,
    required TResult orElse(),
  }) {
    if (callUpdated != null) {
      return callUpdated(callModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCall value) createCall,
    required TResult Function(AcceptCall value) acceptCall,
    required TResult Function(DeclineCall value) declineCall,
    required TResult Function(CancelCall value) cancelCall,
    required TResult Function(EndCall value) endCall,
    required TResult Function(ListenToCall value) listenToCall,
    required TResult Function(CallUpdated value) callUpdated,
  }) {
    return callUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCall value)? createCall,
    TResult? Function(AcceptCall value)? acceptCall,
    TResult? Function(DeclineCall value)? declineCall,
    TResult? Function(CancelCall value)? cancelCall,
    TResult? Function(EndCall value)? endCall,
    TResult? Function(ListenToCall value)? listenToCall,
    TResult? Function(CallUpdated value)? callUpdated,
  }) {
    return callUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCall value)? createCall,
    TResult Function(AcceptCall value)? acceptCall,
    TResult Function(DeclineCall value)? declineCall,
    TResult Function(CancelCall value)? cancelCall,
    TResult Function(EndCall value)? endCall,
    TResult Function(ListenToCall value)? listenToCall,
    TResult Function(CallUpdated value)? callUpdated,
    required TResult orElse(),
  }) {
    if (callUpdated != null) {
      return callUpdated(this);
    }
    return orElse();
  }
}

abstract class CallUpdated implements CallEvent {
  const factory CallUpdated(final CallModel? callModel) = _$CallUpdatedImpl;

  CallModel? get callModel;
  @JsonKey(ignore: true)
  _$$CallUpdatedImplCopyWith<_$CallUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
