// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requests_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RequestsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestsEventCopyWith<$Res> {
  factory $RequestsEventCopyWith(
          RequestsEvent value, $Res Function(RequestsEvent) then) =
      _$RequestsEventCopyWithImpl<$Res, RequestsEvent>;
}

/// @nodoc
class _$RequestsEventCopyWithImpl<$Res, $Val extends RequestsEvent>
    implements $RequestsEventCopyWith<$Res> {
  _$RequestsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'RequestsEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class Started implements RequestsEvent {
  const factory Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$IncomingRequestsUpdatedImplCopyWith<$Res> {
  factory _$$IncomingRequestsUpdatedImplCopyWith(
          _$IncomingRequestsUpdatedImpl value,
          $Res Function(_$IncomingRequestsUpdatedImpl) then) =
      __$$IncomingRequestsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FriendRequest> requests});
}

/// @nodoc
class __$$IncomingRequestsUpdatedImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$IncomingRequestsUpdatedImpl>
    implements _$$IncomingRequestsUpdatedImplCopyWith<$Res> {
  __$$IncomingRequestsUpdatedImplCopyWithImpl(
      _$IncomingRequestsUpdatedImpl _value,
      $Res Function(_$IncomingRequestsUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = null,
  }) {
    return _then(_$IncomingRequestsUpdatedImpl(
      null == requests
          ? _value._requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<FriendRequest>,
    ));
  }
}

/// @nodoc

class _$IncomingRequestsUpdatedImpl implements IncomingRequestsUpdated {
  const _$IncomingRequestsUpdatedImpl(final List<FriendRequest> requests)
      : _requests = requests;

  final List<FriendRequest> _requests;
  @override
  List<FriendRequest> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  String toString() {
    return 'RequestsEvent.incomingRequestsUpdated(requests: $requests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomingRequestsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._requests, _requests));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_requests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomingRequestsUpdatedImplCopyWith<_$IncomingRequestsUpdatedImpl>
      get copyWith => __$$IncomingRequestsUpdatedImplCopyWithImpl<
          _$IncomingRequestsUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return incomingRequestsUpdated(requests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return incomingRequestsUpdated?.call(requests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (incomingRequestsUpdated != null) {
      return incomingRequestsUpdated(requests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return incomingRequestsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return incomingRequestsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (incomingRequestsUpdated != null) {
      return incomingRequestsUpdated(this);
    }
    return orElse();
  }
}

abstract class IncomingRequestsUpdated implements RequestsEvent {
  const factory IncomingRequestsUpdated(final List<FriendRequest> requests) =
      _$IncomingRequestsUpdatedImpl;

  List<FriendRequest> get requests;
  @JsonKey(ignore: true)
  _$$IncomingRequestsUpdatedImplCopyWith<_$IncomingRequestsUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OutgoingRequestsUpdatedImplCopyWith<$Res> {
  factory _$$OutgoingRequestsUpdatedImplCopyWith(
          _$OutgoingRequestsUpdatedImpl value,
          $Res Function(_$OutgoingRequestsUpdatedImpl) then) =
      __$$OutgoingRequestsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FriendRequest> requests});
}

/// @nodoc
class __$$OutgoingRequestsUpdatedImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$OutgoingRequestsUpdatedImpl>
    implements _$$OutgoingRequestsUpdatedImplCopyWith<$Res> {
  __$$OutgoingRequestsUpdatedImplCopyWithImpl(
      _$OutgoingRequestsUpdatedImpl _value,
      $Res Function(_$OutgoingRequestsUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = null,
  }) {
    return _then(_$OutgoingRequestsUpdatedImpl(
      null == requests
          ? _value._requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<FriendRequest>,
    ));
  }
}

/// @nodoc

class _$OutgoingRequestsUpdatedImpl implements OutgoingRequestsUpdated {
  const _$OutgoingRequestsUpdatedImpl(final List<FriendRequest> requests)
      : _requests = requests;

  final List<FriendRequest> _requests;
  @override
  List<FriendRequest> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  String toString() {
    return 'RequestsEvent.outgoingRequestsUpdated(requests: $requests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutgoingRequestsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._requests, _requests));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_requests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutgoingRequestsUpdatedImplCopyWith<_$OutgoingRequestsUpdatedImpl>
      get copyWith => __$$OutgoingRequestsUpdatedImplCopyWithImpl<
          _$OutgoingRequestsUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return outgoingRequestsUpdated(requests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return outgoingRequestsUpdated?.call(requests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (outgoingRequestsUpdated != null) {
      return outgoingRequestsUpdated(requests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return outgoingRequestsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return outgoingRequestsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (outgoingRequestsUpdated != null) {
      return outgoingRequestsUpdated(this);
    }
    return orElse();
  }
}

abstract class OutgoingRequestsUpdated implements RequestsEvent {
  const factory OutgoingRequestsUpdated(final List<FriendRequest> requests) =
      _$OutgoingRequestsUpdatedImpl;

  List<FriendRequest> get requests;
  @JsonKey(ignore: true)
  _$$OutgoingRequestsUpdatedImplCopyWith<_$OutgoingRequestsUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleTabImplCopyWith<$Res> {
  factory _$$ToggleTabImplCopyWith(
          _$ToggleTabImpl value, $Res Function(_$ToggleTabImpl) then) =
      __$$ToggleTabImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isIncoming});
}

/// @nodoc
class __$$ToggleTabImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$ToggleTabImpl>
    implements _$$ToggleTabImplCopyWith<$Res> {
  __$$ToggleTabImplCopyWithImpl(
      _$ToggleTabImpl _value, $Res Function(_$ToggleTabImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isIncoming = null,
  }) {
    return _then(_$ToggleTabImpl(
      isIncoming: null == isIncoming
          ? _value.isIncoming
          : isIncoming // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ToggleTabImpl implements ToggleTab {
  const _$ToggleTabImpl({required this.isIncoming});

  @override
  final bool isIncoming;

  @override
  String toString() {
    return 'RequestsEvent.toggleTab(isIncoming: $isIncoming)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleTabImpl &&
            (identical(other.isIncoming, isIncoming) ||
                other.isIncoming == isIncoming));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isIncoming);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleTabImplCopyWith<_$ToggleTabImpl> get copyWith =>
      __$$ToggleTabImplCopyWithImpl<_$ToggleTabImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return toggleTab(isIncoming);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return toggleTab?.call(isIncoming);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (toggleTab != null) {
      return toggleTab(isIncoming);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return toggleTab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return toggleTab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (toggleTab != null) {
      return toggleTab(this);
    }
    return orElse();
  }
}

abstract class ToggleTab implements RequestsEvent {
  const factory ToggleTab({required final bool isIncoming}) = _$ToggleTabImpl;

  bool get isIncoming;
  @JsonKey(ignore: true)
  _$$ToggleTabImplCopyWith<_$ToggleTabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptRequestImplCopyWith<$Res> {
  factory _$$AcceptRequestImplCopyWith(
          _$AcceptRequestImpl value, $Res Function(_$AcceptRequestImpl) then) =
      __$$AcceptRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId, String fromUserId, String toUserId});
}

/// @nodoc
class __$$AcceptRequestImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$AcceptRequestImpl>
    implements _$$AcceptRequestImplCopyWith<$Res> {
  __$$AcceptRequestImplCopyWithImpl(
      _$AcceptRequestImpl _value, $Res Function(_$AcceptRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
  }) {
    return _then(_$AcceptRequestImpl(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AcceptRequestImpl implements AcceptRequest {
  const _$AcceptRequestImpl(
      {required this.requestId,
      required this.fromUserId,
      required this.toUserId});

  @override
  final String requestId;
  @override
  final String fromUserId;
  @override
  final String toUserId;

  @override
  String toString() {
    return 'RequestsEvent.acceptRequest(requestId: $requestId, fromUserId: $fromUserId, toUserId: $toUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptRequestImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId, fromUserId, toUserId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptRequestImplCopyWith<_$AcceptRequestImpl> get copyWith =>
      __$$AcceptRequestImplCopyWithImpl<_$AcceptRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return acceptRequest(requestId, fromUserId, toUserId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return acceptRequest?.call(requestId, fromUserId, toUserId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (acceptRequest != null) {
      return acceptRequest(requestId, fromUserId, toUserId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return acceptRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return acceptRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (acceptRequest != null) {
      return acceptRequest(this);
    }
    return orElse();
  }
}

abstract class AcceptRequest implements RequestsEvent {
  const factory AcceptRequest(
      {required final String requestId,
      required final String fromUserId,
      required final String toUserId}) = _$AcceptRequestImpl;

  String get requestId;
  String get fromUserId;
  String get toUserId;
  @JsonKey(ignore: true)
  _$$AcceptRequestImplCopyWith<_$AcceptRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeclineRequestImplCopyWith<$Res> {
  factory _$$DeclineRequestImplCopyWith(_$DeclineRequestImpl value,
          $Res Function(_$DeclineRequestImpl) then) =
      __$$DeclineRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId});
}

/// @nodoc
class __$$DeclineRequestImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$DeclineRequestImpl>
    implements _$$DeclineRequestImplCopyWith<$Res> {
  __$$DeclineRequestImplCopyWithImpl(
      _$DeclineRequestImpl _value, $Res Function(_$DeclineRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
  }) {
    return _then(_$DeclineRequestImpl(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeclineRequestImpl implements DeclineRequest {
  const _$DeclineRequestImpl({required this.requestId});

  @override
  final String requestId;

  @override
  String toString() {
    return 'RequestsEvent.declineRequest(requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineRequestImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeclineRequestImplCopyWith<_$DeclineRequestImpl> get copyWith =>
      __$$DeclineRequestImplCopyWithImpl<_$DeclineRequestImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return declineRequest(requestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return declineRequest?.call(requestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (declineRequest != null) {
      return declineRequest(requestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return declineRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return declineRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (declineRequest != null) {
      return declineRequest(this);
    }
    return orElse();
  }
}

abstract class DeclineRequest implements RequestsEvent {
  const factory DeclineRequest({required final String requestId}) =
      _$DeclineRequestImpl;

  String get requestId;
  @JsonKey(ignore: true)
  _$$DeclineRequestImplCopyWith<_$DeclineRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelRequestImplCopyWith<$Res> {
  factory _$$CancelRequestImplCopyWith(
          _$CancelRequestImpl value, $Res Function(_$CancelRequestImpl) then) =
      __$$CancelRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId});
}

/// @nodoc
class __$$CancelRequestImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$CancelRequestImpl>
    implements _$$CancelRequestImplCopyWith<$Res> {
  __$$CancelRequestImplCopyWithImpl(
      _$CancelRequestImpl _value, $Res Function(_$CancelRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
  }) {
    return _then(_$CancelRequestImpl(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CancelRequestImpl implements CancelRequest {
  const _$CancelRequestImpl({required this.requestId});

  @override
  final String requestId;

  @override
  String toString() {
    return 'RequestsEvent.cancelRequest(requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelRequestImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelRequestImplCopyWith<_$CancelRequestImpl> get copyWith =>
      __$$CancelRequestImplCopyWithImpl<_$CancelRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return cancelRequest(requestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return cancelRequest?.call(requestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (cancelRequest != null) {
      return cancelRequest(requestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return cancelRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return cancelRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (cancelRequest != null) {
      return cancelRequest(this);
    }
    return orElse();
  }
}

abstract class CancelRequest implements RequestsEvent {
  const factory CancelRequest({required final String requestId}) =
      _$CancelRequestImpl;

  String get requestId;
  @JsonKey(ignore: true)
  _$$CancelRequestImplCopyWith<_$CancelRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorOccurredImplCopyWith<$Res> {
  factory _$$ErrorOccurredImplCopyWith(
          _$ErrorOccurredImpl value, $Res Function(_$ErrorOccurredImpl) then) =
      __$$ErrorOccurredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorOccurredImplCopyWithImpl<$Res>
    extends _$RequestsEventCopyWithImpl<$Res, _$ErrorOccurredImpl>
    implements _$$ErrorOccurredImplCopyWith<$Res> {
  __$$ErrorOccurredImplCopyWithImpl(
      _$ErrorOccurredImpl _value, $Res Function(_$ErrorOccurredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorOccurredImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorOccurredImpl implements ErrorOccurred {
  const _$ErrorOccurredImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RequestsEvent.errorOccurred(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorOccurredImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      __$$ErrorOccurredImplCopyWithImpl<_$ErrorOccurredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<FriendRequest> requests)
        incomingRequestsUpdated,
    required TResult Function(List<FriendRequest> requests)
        outgoingRequestsUpdated,
    required TResult Function(bool isIncoming) toggleTab,
    required TResult Function(
            String requestId, String fromUserId, String toUserId)
        acceptRequest,
    required TResult Function(String requestId) declineRequest,
    required TResult Function(String requestId) cancelRequest,
    required TResult Function(String message) errorOccurred,
  }) {
    return errorOccurred(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult? Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult? Function(bool isIncoming)? toggleTab,
    TResult? Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult? Function(String requestId)? declineRequest,
    TResult? Function(String requestId)? cancelRequest,
    TResult? Function(String message)? errorOccurred,
  }) {
    return errorOccurred?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<FriendRequest> requests)? incomingRequestsUpdated,
    TResult Function(List<FriendRequest> requests)? outgoingRequestsUpdated,
    TResult Function(bool isIncoming)? toggleTab,
    TResult Function(String requestId, String fromUserId, String toUserId)?
        acceptRequest,
    TResult Function(String requestId)? declineRequest,
    TResult Function(String requestId)? cancelRequest,
    TResult Function(String message)? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(IncomingRequestsUpdated value)
        incomingRequestsUpdated,
    required TResult Function(OutgoingRequestsUpdated value)
        outgoingRequestsUpdated,
    required TResult Function(ToggleTab value) toggleTab,
    required TResult Function(AcceptRequest value) acceptRequest,
    required TResult Function(DeclineRequest value) declineRequest,
    required TResult Function(CancelRequest value) cancelRequest,
    required TResult Function(ErrorOccurred value) errorOccurred,
  }) {
    return errorOccurred(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult? Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult? Function(ToggleTab value)? toggleTab,
    TResult? Function(AcceptRequest value)? acceptRequest,
    TResult? Function(DeclineRequest value)? declineRequest,
    TResult? Function(CancelRequest value)? cancelRequest,
    TResult? Function(ErrorOccurred value)? errorOccurred,
  }) {
    return errorOccurred?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(IncomingRequestsUpdated value)? incomingRequestsUpdated,
    TResult Function(OutgoingRequestsUpdated value)? outgoingRequestsUpdated,
    TResult Function(ToggleTab value)? toggleTab,
    TResult Function(AcceptRequest value)? acceptRequest,
    TResult Function(DeclineRequest value)? declineRequest,
    TResult Function(CancelRequest value)? cancelRequest,
    TResult Function(ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(this);
    }
    return orElse();
  }
}

abstract class ErrorOccurred implements RequestsEvent {
  const factory ErrorOccurred(final String message) = _$ErrorOccurredImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorOccurredImplCopyWith<_$ErrorOccurredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
