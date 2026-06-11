// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiscoverState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searching,
    required TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)
        results,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searching,
    TResult? Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searching,
    TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searching value) searching,
    required TResult Function(DiscoverResults value) results,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searching value)? searching,
    TResult? Function(DiscoverResults value)? results,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searching value)? searching,
    TResult Function(DiscoverResults value)? results,
    TResult Function(_Empty value)? empty,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoverStateCopyWith<$Res> {
  factory $DiscoverStateCopyWith(
          DiscoverState value, $Res Function(DiscoverState) then) =
      _$DiscoverStateCopyWithImpl<$Res, DiscoverState>;
}

/// @nodoc
class _$DiscoverStateCopyWithImpl<$Res, $Val extends DiscoverState>
    implements $DiscoverStateCopyWith<$Res> {
  _$DiscoverStateCopyWithImpl(this._value, this._then);

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
    extends _$DiscoverStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'DiscoverState.initial()';
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
    required TResult Function() searching,
    required TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)
        results,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searching,
    TResult? Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searching,
    TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult Function()? empty,
    TResult Function(String message)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searching value) searching,
    required TResult Function(DiscoverResults value) results,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searching value)? searching,
    TResult? Function(DiscoverResults value)? results,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searching value)? searching,
    TResult Function(DiscoverResults value)? results,
    TResult Function(_Empty value)? empty,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements DiscoverState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SearchingImplCopyWith<$Res> {
  factory _$$SearchingImplCopyWith(
          _$SearchingImpl value, $Res Function(_$SearchingImpl) then) =
      __$$SearchingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchingImplCopyWithImpl<$Res>
    extends _$DiscoverStateCopyWithImpl<$Res, _$SearchingImpl>
    implements _$$SearchingImplCopyWith<$Res> {
  __$$SearchingImplCopyWithImpl(
      _$SearchingImpl _value, $Res Function(_$SearchingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchingImpl implements _Searching {
  const _$SearchingImpl();

  @override
  String toString() {
    return 'DiscoverState.searching()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searching,
    required TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)
        results,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return searching();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searching,
    TResult? Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return searching?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searching,
    TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (searching != null) {
      return searching();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searching value) searching,
    required TResult Function(DiscoverResults value) results,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Error value) error,
  }) {
    return searching(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searching value)? searching,
    TResult? Function(DiscoverResults value)? results,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Error value)? error,
  }) {
    return searching?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searching value)? searching,
    TResult Function(DiscoverResults value)? results,
    TResult Function(_Empty value)? empty,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (searching != null) {
      return searching(this);
    }
    return orElse();
  }
}

abstract class _Searching implements DiscoverState {
  const factory _Searching() = _$SearchingImpl;
}

/// @nodoc
abstract class _$$DiscoverResultsImplCopyWith<$Res> {
  factory _$$DiscoverResultsImplCopyWith(_$DiscoverResultsImpl value,
          $Res Function(_$DiscoverResultsImpl) then) =
      __$$DiscoverResultsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<UserProfile> users,
      Map<String, FriendshipStatus> friendshipStatuses,
      Set<String> sendingRequestUserIds,
      Map<String, String?> actionErrors});
}

/// @nodoc
class __$$DiscoverResultsImplCopyWithImpl<$Res>
    extends _$DiscoverStateCopyWithImpl<$Res, _$DiscoverResultsImpl>
    implements _$$DiscoverResultsImplCopyWith<$Res> {
  __$$DiscoverResultsImplCopyWithImpl(
      _$DiscoverResultsImpl _value, $Res Function(_$DiscoverResultsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? friendshipStatuses = null,
    Object? sendingRequestUserIds = null,
    Object? actionErrors = null,
  }) {
    return _then(_$DiscoverResultsImpl(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserProfile>,
      friendshipStatuses: null == friendshipStatuses
          ? _value._friendshipStatuses
          : friendshipStatuses // ignore: cast_nullable_to_non_nullable
              as Map<String, FriendshipStatus>,
      sendingRequestUserIds: null == sendingRequestUserIds
          ? _value._sendingRequestUserIds
          : sendingRequestUserIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      actionErrors: null == actionErrors
          ? _value._actionErrors
          : actionErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc

class _$DiscoverResultsImpl implements DiscoverResults {
  const _$DiscoverResultsImpl(
      {required final List<UserProfile> users,
      required final Map<String, FriendshipStatus> friendshipStatuses,
      required final Set<String> sendingRequestUserIds,
      required final Map<String, String?> actionErrors})
      : _users = users,
        _friendshipStatuses = friendshipStatuses,
        _sendingRequestUserIds = sendingRequestUserIds,
        _actionErrors = actionErrors;

  final List<UserProfile> _users;
  @override
  List<UserProfile> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final Map<String, FriendshipStatus> _friendshipStatuses;
  @override
  Map<String, FriendshipStatus> get friendshipStatuses {
    if (_friendshipStatuses is EqualUnmodifiableMapView)
      return _friendshipStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_friendshipStatuses);
  }

  final Set<String> _sendingRequestUserIds;
  @override
  Set<String> get sendingRequestUserIds {
    if (_sendingRequestUserIds is EqualUnmodifiableSetView)
      return _sendingRequestUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sendingRequestUserIds);
  }

  final Map<String, String?> _actionErrors;
  @override
  Map<String, String?> get actionErrors {
    if (_actionErrors is EqualUnmodifiableMapView) return _actionErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actionErrors);
  }

  @override
  String toString() {
    return 'DiscoverState.results(users: $users, friendshipStatuses: $friendshipStatuses, sendingRequestUserIds: $sendingRequestUserIds, actionErrors: $actionErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoverResultsImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality()
                .equals(other._friendshipStatuses, _friendshipStatuses) &&
            const DeepCollectionEquality()
                .equals(other._sendingRequestUserIds, _sendingRequestUserIds) &&
            const DeepCollectionEquality()
                .equals(other._actionErrors, _actionErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_users),
      const DeepCollectionEquality().hash(_friendshipStatuses),
      const DeepCollectionEquality().hash(_sendingRequestUserIds),
      const DeepCollectionEquality().hash(_actionErrors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoverResultsImplCopyWith<_$DiscoverResultsImpl> get copyWith =>
      __$$DiscoverResultsImplCopyWithImpl<_$DiscoverResultsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searching,
    required TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)
        results,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return results(
        users, friendshipStatuses, sendingRequestUserIds, actionErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searching,
    TResult? Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return results?.call(
        users, friendshipStatuses, sendingRequestUserIds, actionErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searching,
    TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (results != null) {
      return results(
          users, friendshipStatuses, sendingRequestUserIds, actionErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searching value) searching,
    required TResult Function(DiscoverResults value) results,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Error value) error,
  }) {
    return results(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searching value)? searching,
    TResult? Function(DiscoverResults value)? results,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Error value)? error,
  }) {
    return results?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searching value)? searching,
    TResult Function(DiscoverResults value)? results,
    TResult Function(_Empty value)? empty,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (results != null) {
      return results(this);
    }
    return orElse();
  }
}

abstract class DiscoverResults implements DiscoverState {
  const factory DiscoverResults(
          {required final List<UserProfile> users,
          required final Map<String, FriendshipStatus> friendshipStatuses,
          required final Set<String> sendingRequestUserIds,
          required final Map<String, String?> actionErrors}) =
      _$DiscoverResultsImpl;

  List<UserProfile> get users;
  Map<String, FriendshipStatus> get friendshipStatuses;
  Set<String> get sendingRequestUserIds;
  Map<String, String?> get actionErrors;
  @JsonKey(ignore: true)
  _$$DiscoverResultsImplCopyWith<_$DiscoverResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmptyImplCopyWith<$Res> {
  factory _$$EmptyImplCopyWith(
          _$EmptyImpl value, $Res Function(_$EmptyImpl) then) =
      __$$EmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyImplCopyWithImpl<$Res>
    extends _$DiscoverStateCopyWithImpl<$Res, _$EmptyImpl>
    implements _$$EmptyImplCopyWith<$Res> {
  __$$EmptyImplCopyWithImpl(
      _$EmptyImpl _value, $Res Function(_$EmptyImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EmptyImpl implements _Empty {
  const _$EmptyImpl();

  @override
  String toString() {
    return 'DiscoverState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searching,
    required TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)
        results,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searching,
    TResult? Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searching,
    TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searching value) searching,
    required TResult Function(DiscoverResults value) results,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Error value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searching value)? searching,
    TResult? Function(DiscoverResults value)? results,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Error value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searching value)? searching,
    TResult Function(DiscoverResults value)? results,
    TResult Function(_Empty value)? empty,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements DiscoverState {
  const factory _Empty() = _$EmptyImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$DiscoverStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'DiscoverState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() searching,
    required TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)
        results,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? searching,
    TResult? Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? searching,
    TResult Function(
            List<UserProfile> users,
            Map<String, FriendshipStatus> friendshipStatuses,
            Set<String> sendingRequestUserIds,
            Map<String, String?> actionErrors)?
        results,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Searching value) searching,
    required TResult Function(DiscoverResults value) results,
    required TResult Function(_Empty value) empty,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Searching value)? searching,
    TResult? Function(DiscoverResults value)? results,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Searching value)? searching,
    TResult Function(DiscoverResults value)? results,
    TResult Function(_Empty value)? empty,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DiscoverState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
