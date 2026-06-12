// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presence_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PresenceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() online,
    required TResult Function() background,
    required TResult Function(DateTime lastSeen) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? online,
    TResult? Function()? background,
    TResult? Function(DateTime lastSeen)? offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? online,
    TResult Function()? background,
    TResult Function(DateTime lastSeen)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Online value) online,
    required TResult Function(Background value) background,
    required TResult Function(Offline value) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Online value)? online,
    TResult? Function(Background value)? background,
    TResult? Function(Offline value)? offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Online value)? online,
    TResult Function(Background value)? background,
    TResult Function(Offline value)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceStateCopyWith<$Res> {
  factory $PresenceStateCopyWith(
          PresenceState value, $Res Function(PresenceState) then) =
      _$PresenceStateCopyWithImpl<$Res, PresenceState>;
}

/// @nodoc
class _$PresenceStateCopyWithImpl<$Res, $Val extends PresenceState>
    implements $PresenceStateCopyWith<$Res> {
  _$PresenceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UnknownImplCopyWith<$Res> {
  factory _$$UnknownImplCopyWith(
          _$UnknownImpl value, $Res Function(_$UnknownImpl) then) =
      __$$UnknownImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnknownImplCopyWithImpl<$Res>
    extends _$PresenceStateCopyWithImpl<$Res, _$UnknownImpl>
    implements _$$UnknownImplCopyWith<$Res> {
  __$$UnknownImplCopyWithImpl(
      _$UnknownImpl _value, $Res Function(_$UnknownImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnknownImpl implements Unknown {
  const _$UnknownImpl();

  @override
  String toString() {
    return 'PresenceState.unknown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnknownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() online,
    required TResult Function() background,
    required TResult Function(DateTime lastSeen) offline,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? online,
    TResult? Function()? background,
    TResult? Function(DateTime lastSeen)? offline,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? online,
    TResult Function()? background,
    TResult Function(DateTime lastSeen)? offline,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Online value) online,
    required TResult Function(Background value) background,
    required TResult Function(Offline value) offline,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Online value)? online,
    TResult? Function(Background value)? background,
    TResult? Function(Offline value)? offline,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Online value)? online,
    TResult Function(Background value)? background,
    TResult Function(Offline value)? offline,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class Unknown implements PresenceState {
  const factory Unknown() = _$UnknownImpl;
}

/// @nodoc
abstract class _$$OnlineImplCopyWith<$Res> {
  factory _$$OnlineImplCopyWith(
          _$OnlineImpl value, $Res Function(_$OnlineImpl) then) =
      __$$OnlineImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnlineImplCopyWithImpl<$Res>
    extends _$PresenceStateCopyWithImpl<$Res, _$OnlineImpl>
    implements _$$OnlineImplCopyWith<$Res> {
  __$$OnlineImplCopyWithImpl(
      _$OnlineImpl _value, $Res Function(_$OnlineImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OnlineImpl implements Online {
  const _$OnlineImpl();

  @override
  String toString() {
    return 'PresenceState.online()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnlineImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() online,
    required TResult Function() background,
    required TResult Function(DateTime lastSeen) offline,
  }) {
    return online();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? online,
    TResult? Function()? background,
    TResult? Function(DateTime lastSeen)? offline,
  }) {
    return online?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? online,
    TResult Function()? background,
    TResult Function(DateTime lastSeen)? offline,
    required TResult orElse(),
  }) {
    if (online != null) {
      return online();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Online value) online,
    required TResult Function(Background value) background,
    required TResult Function(Offline value) offline,
  }) {
    return online(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Online value)? online,
    TResult? Function(Background value)? background,
    TResult? Function(Offline value)? offline,
  }) {
    return online?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Online value)? online,
    TResult Function(Background value)? background,
    TResult Function(Offline value)? offline,
    required TResult orElse(),
  }) {
    if (online != null) {
      return online(this);
    }
    return orElse();
  }
}

abstract class Online implements PresenceState {
  const factory Online() = _$OnlineImpl;
}

/// @nodoc
abstract class _$$BackgroundImplCopyWith<$Res> {
  factory _$$BackgroundImplCopyWith(
          _$BackgroundImpl value, $Res Function(_$BackgroundImpl) then) =
      __$$BackgroundImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackgroundImplCopyWithImpl<$Res>
    extends _$PresenceStateCopyWithImpl<$Res, _$BackgroundImpl>
    implements _$$BackgroundImplCopyWith<$Res> {
  __$$BackgroundImplCopyWithImpl(
      _$BackgroundImpl _value, $Res Function(_$BackgroundImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BackgroundImpl implements Background {
  const _$BackgroundImpl();

  @override
  String toString() {
    return 'PresenceState.background()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackgroundImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() online,
    required TResult Function() background,
    required TResult Function(DateTime lastSeen) offline,
  }) {
    return background();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? online,
    TResult? Function()? background,
    TResult? Function(DateTime lastSeen)? offline,
  }) {
    return background?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? online,
    TResult Function()? background,
    TResult Function(DateTime lastSeen)? offline,
    required TResult orElse(),
  }) {
    if (background != null) {
      return background();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Online value) online,
    required TResult Function(Background value) background,
    required TResult Function(Offline value) offline,
  }) {
    return background(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Online value)? online,
    TResult? Function(Background value)? background,
    TResult? Function(Offline value)? offline,
  }) {
    return background?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Online value)? online,
    TResult Function(Background value)? background,
    TResult Function(Offline value)? offline,
    required TResult orElse(),
  }) {
    if (background != null) {
      return background(this);
    }
    return orElse();
  }
}

abstract class Background implements PresenceState {
  const factory Background() = _$BackgroundImpl;
}

/// @nodoc
abstract class _$$OfflineImplCopyWith<$Res> {
  factory _$$OfflineImplCopyWith(
          _$OfflineImpl value, $Res Function(_$OfflineImpl) then) =
      __$$OfflineImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime lastSeen});
}

/// @nodoc
class __$$OfflineImplCopyWithImpl<$Res>
    extends _$PresenceStateCopyWithImpl<$Res, _$OfflineImpl>
    implements _$$OfflineImplCopyWith<$Res> {
  __$$OfflineImplCopyWithImpl(
      _$OfflineImpl _value, $Res Function(_$OfflineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSeen = null,
  }) {
    return _then(_$OfflineImpl(
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$OfflineImpl implements Offline {
  const _$OfflineImpl({required this.lastSeen});

  @override
  final DateTime lastSeen;

  @override
  String toString() {
    return 'PresenceState.offline(lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineImpl &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastSeen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineImplCopyWith<_$OfflineImpl> get copyWith =>
      __$$OfflineImplCopyWithImpl<_$OfflineImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() online,
    required TResult Function() background,
    required TResult Function(DateTime lastSeen) offline,
  }) {
    return offline(lastSeen);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function()? online,
    TResult? Function()? background,
    TResult? Function(DateTime lastSeen)? offline,
  }) {
    return offline?.call(lastSeen);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? online,
    TResult Function()? background,
    TResult Function(DateTime lastSeen)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(lastSeen);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(Online value) online,
    required TResult Function(Background value) background,
    required TResult Function(Offline value) offline,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unknown value)? unknown,
    TResult? Function(Online value)? online,
    TResult? Function(Background value)? background,
    TResult? Function(Offline value)? offline,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(Online value)? online,
    TResult Function(Background value)? background,
    TResult Function(Offline value)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class Offline implements PresenceState {
  const factory Offline({required final DateTime lastSeen}) = _$OfflineImpl;

  DateTime get lastSeen;
  @JsonKey(ignore: true)
  _$$OfflineImplCopyWith<_$OfflineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
