// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiscoverEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() searchStarted,
    required TResult Function(String userId) userSelected,
    required TResult Function(String targetUserId) sendFriendRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? searchStarted,
    TResult? Function(String userId)? userSelected,
    TResult? Function(String targetUserId)? sendFriendRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? searchStarted,
    TResult Function(String userId)? userSelected,
    TResult Function(String targetUserId)? sendFriendRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(SearchStarted value) searchStarted,
    required TResult Function(UserSelected value) userSelected,
    required TResult Function(SendFriendRequest value) sendFriendRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(SearchStarted value)? searchStarted,
    TResult? Function(UserSelected value)? userSelected,
    TResult? Function(SendFriendRequest value)? sendFriendRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(SearchStarted value)? searchStarted,
    TResult Function(UserSelected value)? userSelected,
    TResult Function(SendFriendRequest value)? sendFriendRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoverEventCopyWith<$Res> {
  factory $DiscoverEventCopyWith(
          DiscoverEvent value, $Res Function(DiscoverEvent) then) =
      _$DiscoverEventCopyWithImpl<$Res, DiscoverEvent>;
}

/// @nodoc
class _$DiscoverEventCopyWithImpl<$Res, $Val extends DiscoverEvent>
    implements $DiscoverEventCopyWith<$Res> {
  _$DiscoverEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SearchQueryChangedImplCopyWith<$Res> {
  factory _$$SearchQueryChangedImplCopyWith(_$SearchQueryChangedImpl value,
          $Res Function(_$SearchQueryChangedImpl) then) =
      __$$SearchQueryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchQueryChangedImplCopyWithImpl<$Res>
    extends _$DiscoverEventCopyWithImpl<$Res, _$SearchQueryChangedImpl>
    implements _$$SearchQueryChangedImplCopyWith<$Res> {
  __$$SearchQueryChangedImplCopyWithImpl(_$SearchQueryChangedImpl _value,
      $Res Function(_$SearchQueryChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchQueryChangedImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchQueryChangedImpl implements SearchQueryChanged {
  const _$SearchQueryChangedImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'DiscoverEvent.searchQueryChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchQueryChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      __$$SearchQueryChangedImplCopyWithImpl<_$SearchQueryChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() searchStarted,
    required TResult Function(String userId) userSelected,
    required TResult Function(String targetUserId) sendFriendRequest,
  }) {
    return searchQueryChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? searchStarted,
    TResult? Function(String userId)? userSelected,
    TResult? Function(String targetUserId)? sendFriendRequest,
  }) {
    return searchQueryChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? searchStarted,
    TResult Function(String userId)? userSelected,
    TResult Function(String targetUserId)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(SearchStarted value) searchStarted,
    required TResult Function(UserSelected value) userSelected,
    required TResult Function(SendFriendRequest value) sendFriendRequest,
  }) {
    return searchQueryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(SearchStarted value)? searchStarted,
    TResult? Function(UserSelected value)? userSelected,
    TResult? Function(SendFriendRequest value)? sendFriendRequest,
  }) {
    return searchQueryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(SearchStarted value)? searchStarted,
    TResult Function(UserSelected value)? userSelected,
    TResult Function(SendFriendRequest value)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(this);
    }
    return orElse();
  }
}

abstract class SearchQueryChanged implements DiscoverEvent {
  const factory SearchQueryChanged(final String query) =
      _$SearchQueryChangedImpl;

  String get query;
  @JsonKey(ignore: true)
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchStartedImplCopyWith<$Res> {
  factory _$$SearchStartedImplCopyWith(
          _$SearchStartedImpl value, $Res Function(_$SearchStartedImpl) then) =
      __$$SearchStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchStartedImplCopyWithImpl<$Res>
    extends _$DiscoverEventCopyWithImpl<$Res, _$SearchStartedImpl>
    implements _$$SearchStartedImplCopyWith<$Res> {
  __$$SearchStartedImplCopyWithImpl(
      _$SearchStartedImpl _value, $Res Function(_$SearchStartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchStartedImpl implements SearchStarted {
  const _$SearchStartedImpl();

  @override
  String toString() {
    return 'DiscoverEvent.searchStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() searchStarted,
    required TResult Function(String userId) userSelected,
    required TResult Function(String targetUserId) sendFriendRequest,
  }) {
    return searchStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? searchStarted,
    TResult? Function(String userId)? userSelected,
    TResult? Function(String targetUserId)? sendFriendRequest,
  }) {
    return searchStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? searchStarted,
    TResult Function(String userId)? userSelected,
    TResult Function(String targetUserId)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (searchStarted != null) {
      return searchStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(SearchStarted value) searchStarted,
    required TResult Function(UserSelected value) userSelected,
    required TResult Function(SendFriendRequest value) sendFriendRequest,
  }) {
    return searchStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(SearchStarted value)? searchStarted,
    TResult? Function(UserSelected value)? userSelected,
    TResult? Function(SendFriendRequest value)? sendFriendRequest,
  }) {
    return searchStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(SearchStarted value)? searchStarted,
    TResult Function(UserSelected value)? userSelected,
    TResult Function(SendFriendRequest value)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (searchStarted != null) {
      return searchStarted(this);
    }
    return orElse();
  }
}

abstract class SearchStarted implements DiscoverEvent {
  const factory SearchStarted() = _$SearchStartedImpl;
}

/// @nodoc
abstract class _$$UserSelectedImplCopyWith<$Res> {
  factory _$$UserSelectedImplCopyWith(
          _$UserSelectedImpl value, $Res Function(_$UserSelectedImpl) then) =
      __$$UserSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$UserSelectedImplCopyWithImpl<$Res>
    extends _$DiscoverEventCopyWithImpl<$Res, _$UserSelectedImpl>
    implements _$$UserSelectedImplCopyWith<$Res> {
  __$$UserSelectedImplCopyWithImpl(
      _$UserSelectedImpl _value, $Res Function(_$UserSelectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$UserSelectedImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserSelectedImpl implements UserSelected {
  const _$UserSelectedImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'DiscoverEvent.userSelected(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSelectedImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSelectedImplCopyWith<_$UserSelectedImpl> get copyWith =>
      __$$UserSelectedImplCopyWithImpl<_$UserSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() searchStarted,
    required TResult Function(String userId) userSelected,
    required TResult Function(String targetUserId) sendFriendRequest,
  }) {
    return userSelected(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? searchStarted,
    TResult? Function(String userId)? userSelected,
    TResult? Function(String targetUserId)? sendFriendRequest,
  }) {
    return userSelected?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? searchStarted,
    TResult Function(String userId)? userSelected,
    TResult Function(String targetUserId)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (userSelected != null) {
      return userSelected(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(SearchStarted value) searchStarted,
    required TResult Function(UserSelected value) userSelected,
    required TResult Function(SendFriendRequest value) sendFriendRequest,
  }) {
    return userSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(SearchStarted value)? searchStarted,
    TResult? Function(UserSelected value)? userSelected,
    TResult? Function(SendFriendRequest value)? sendFriendRequest,
  }) {
    return userSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(SearchStarted value)? searchStarted,
    TResult Function(UserSelected value)? userSelected,
    TResult Function(SendFriendRequest value)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (userSelected != null) {
      return userSelected(this);
    }
    return orElse();
  }
}

abstract class UserSelected implements DiscoverEvent {
  const factory UserSelected(final String userId) = _$UserSelectedImpl;

  String get userId;
  @JsonKey(ignore: true)
  _$$UserSelectedImplCopyWith<_$UserSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendFriendRequestImplCopyWith<$Res> {
  factory _$$SendFriendRequestImplCopyWith(_$SendFriendRequestImpl value,
          $Res Function(_$SendFriendRequestImpl) then) =
      __$$SendFriendRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String targetUserId});
}

/// @nodoc
class __$$SendFriendRequestImplCopyWithImpl<$Res>
    extends _$DiscoverEventCopyWithImpl<$Res, _$SendFriendRequestImpl>
    implements _$$SendFriendRequestImplCopyWith<$Res> {
  __$$SendFriendRequestImplCopyWithImpl(_$SendFriendRequestImpl _value,
      $Res Function(_$SendFriendRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetUserId = null,
  }) {
    return _then(_$SendFriendRequestImpl(
      targetUserId: null == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendFriendRequestImpl implements SendFriendRequest {
  const _$SendFriendRequestImpl({required this.targetUserId});

  @override
  final String targetUserId;

  @override
  String toString() {
    return 'DiscoverEvent.sendFriendRequest(targetUserId: $targetUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendFriendRequestImpl &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, targetUserId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendFriendRequestImplCopyWith<_$SendFriendRequestImpl> get copyWith =>
      __$$SendFriendRequestImplCopyWithImpl<_$SendFriendRequestImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() searchStarted,
    required TResult Function(String userId) userSelected,
    required TResult Function(String targetUserId) sendFriendRequest,
  }) {
    return sendFriendRequest(targetUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? searchStarted,
    TResult? Function(String userId)? userSelected,
    TResult? Function(String targetUserId)? sendFriendRequest,
  }) {
    return sendFriendRequest?.call(targetUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? searchStarted,
    TResult Function(String userId)? userSelected,
    TResult Function(String targetUserId)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (sendFriendRequest != null) {
      return sendFriendRequest(targetUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(SearchStarted value) searchStarted,
    required TResult Function(UserSelected value) userSelected,
    required TResult Function(SendFriendRequest value) sendFriendRequest,
  }) {
    return sendFriendRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(SearchStarted value)? searchStarted,
    TResult? Function(UserSelected value)? userSelected,
    TResult? Function(SendFriendRequest value)? sendFriendRequest,
  }) {
    return sendFriendRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(SearchStarted value)? searchStarted,
    TResult Function(UserSelected value)? userSelected,
    TResult Function(SendFriendRequest value)? sendFriendRequest,
    required TResult orElse(),
  }) {
    if (sendFriendRequest != null) {
      return sendFriendRequest(this);
    }
    return orElse();
  }
}

abstract class SendFriendRequest implements DiscoverEvent {
  const factory SendFriendRequest({required final String targetUserId}) =
      _$SendFriendRequestImpl;

  String get targetUserId;
  @JsonKey(ignore: true)
  _$$SendFriendRequestImplCopyWith<_$SendFriendRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
