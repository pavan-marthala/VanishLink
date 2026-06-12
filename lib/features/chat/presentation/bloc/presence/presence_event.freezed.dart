// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presence_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PresenceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) monitorUser,
    required TResult Function(PresenceStatus status) presenceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? monitorUser,
    TResult? Function(PresenceStatus status)? presenceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? monitorUser,
    TResult Function(PresenceStatus status)? presenceUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MonitorUser value) monitorUser,
    required TResult Function(PresenceUpdated value) presenceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MonitorUser value)? monitorUser,
    TResult? Function(PresenceUpdated value)? presenceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MonitorUser value)? monitorUser,
    TResult Function(PresenceUpdated value)? presenceUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceEventCopyWith<$Res> {
  factory $PresenceEventCopyWith(
          PresenceEvent value, $Res Function(PresenceEvent) then) =
      _$PresenceEventCopyWithImpl<$Res, PresenceEvent>;
}

/// @nodoc
class _$PresenceEventCopyWithImpl<$Res, $Val extends PresenceEvent>
    implements $PresenceEventCopyWith<$Res> {
  _$PresenceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MonitorUserImplCopyWith<$Res> {
  factory _$$MonitorUserImplCopyWith(
          _$MonitorUserImpl value, $Res Function(_$MonitorUserImpl) then) =
      __$$MonitorUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$MonitorUserImplCopyWithImpl<$Res>
    extends _$PresenceEventCopyWithImpl<$Res, _$MonitorUserImpl>
    implements _$$MonitorUserImplCopyWith<$Res> {
  __$$MonitorUserImplCopyWithImpl(
      _$MonitorUserImpl _value, $Res Function(_$MonitorUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$MonitorUserImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MonitorUserImpl implements MonitorUser {
  const _$MonitorUserImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'PresenceEvent.monitorUser(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitorUserImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitorUserImplCopyWith<_$MonitorUserImpl> get copyWith =>
      __$$MonitorUserImplCopyWithImpl<_$MonitorUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) monitorUser,
    required TResult Function(PresenceStatus status) presenceUpdated,
  }) {
    return monitorUser(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? monitorUser,
    TResult? Function(PresenceStatus status)? presenceUpdated,
  }) {
    return monitorUser?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? monitorUser,
    TResult Function(PresenceStatus status)? presenceUpdated,
    required TResult orElse(),
  }) {
    if (monitorUser != null) {
      return monitorUser(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MonitorUser value) monitorUser,
    required TResult Function(PresenceUpdated value) presenceUpdated,
  }) {
    return monitorUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MonitorUser value)? monitorUser,
    TResult? Function(PresenceUpdated value)? presenceUpdated,
  }) {
    return monitorUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MonitorUser value)? monitorUser,
    TResult Function(PresenceUpdated value)? presenceUpdated,
    required TResult orElse(),
  }) {
    if (monitorUser != null) {
      return monitorUser(this);
    }
    return orElse();
  }
}

abstract class MonitorUser implements PresenceEvent {
  const factory MonitorUser(final String userId) = _$MonitorUserImpl;

  String get userId;
  @JsonKey(ignore: true)
  _$$MonitorUserImplCopyWith<_$MonitorUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresenceUpdatedImplCopyWith<$Res> {
  factory _$$PresenceUpdatedImplCopyWith(_$PresenceUpdatedImpl value,
          $Res Function(_$PresenceUpdatedImpl) then) =
      __$$PresenceUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PresenceStatus status});
}

/// @nodoc
class __$$PresenceUpdatedImplCopyWithImpl<$Res>
    extends _$PresenceEventCopyWithImpl<$Res, _$PresenceUpdatedImpl>
    implements _$$PresenceUpdatedImplCopyWith<$Res> {
  __$$PresenceUpdatedImplCopyWithImpl(
      _$PresenceUpdatedImpl _value, $Res Function(_$PresenceUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$PresenceUpdatedImpl(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PresenceStatus,
    ));
  }
}

/// @nodoc

class _$PresenceUpdatedImpl implements PresenceUpdated {
  const _$PresenceUpdatedImpl(this.status);

  @override
  final PresenceStatus status;

  @override
  String toString() {
    return 'PresenceEvent.presenceUpdated(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresenceUpdatedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresenceUpdatedImplCopyWith<_$PresenceUpdatedImpl> get copyWith =>
      __$$PresenceUpdatedImplCopyWithImpl<_$PresenceUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) monitorUser,
    required TResult Function(PresenceStatus status) presenceUpdated,
  }) {
    return presenceUpdated(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? monitorUser,
    TResult? Function(PresenceStatus status)? presenceUpdated,
  }) {
    return presenceUpdated?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? monitorUser,
    TResult Function(PresenceStatus status)? presenceUpdated,
    required TResult orElse(),
  }) {
    if (presenceUpdated != null) {
      return presenceUpdated(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MonitorUser value) monitorUser,
    required TResult Function(PresenceUpdated value) presenceUpdated,
  }) {
    return presenceUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MonitorUser value)? monitorUser,
    TResult? Function(PresenceUpdated value)? presenceUpdated,
  }) {
    return presenceUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MonitorUser value)? monitorUser,
    TResult Function(PresenceUpdated value)? presenceUpdated,
    required TResult orElse(),
  }) {
    if (presenceUpdated != null) {
      return presenceUpdated(this);
    }
    return orElse();
  }
}

abstract class PresenceUpdated implements PresenceEvent {
  const factory PresenceUpdated(final PresenceStatus status) =
      _$PresenceUpdatedImpl;

  PresenceStatus get status;
  @JsonKey(ignore: true)
  _$$PresenceUpdatedImplCopyWith<_$PresenceUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
