// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RequestsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(RequestsLoaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(RequestsLoaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(RequestsLoaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestsStateCopyWith<$Res> {
  factory $RequestsStateCopyWith(
          RequestsState value, $Res Function(RequestsState) then) =
      _$RequestsStateCopyWithImpl<$Res, RequestsState>;
}

/// @nodoc
class _$RequestsStateCopyWithImpl<$Res, $Val extends RequestsState>
    implements $RequestsStateCopyWith<$Res> {
  _$RequestsStateCopyWithImpl(this._value, this._then);

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
    extends _$RequestsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'RequestsState.initial()';
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
    required TResult Function() loading,
    required TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(RequestsLoaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(RequestsLoaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(RequestsLoaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RequestsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$RequestsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'RequestsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(RequestsLoaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(RequestsLoaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(RequestsLoaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements RequestsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$RequestsLoadedImplCopyWith<$Res> {
  factory _$$RequestsLoadedImplCopyWith(_$RequestsLoadedImpl value,
          $Res Function(_$RequestsLoadedImpl) then) =
      __$$RequestsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<FriendRequest> incomingRequests,
      List<FriendRequest> outgoingRequests,
      bool isIncomingTab,
      Set<String> processingRequestIds,
      String? actionError});
}

/// @nodoc
class __$$RequestsLoadedImplCopyWithImpl<$Res>
    extends _$RequestsStateCopyWithImpl<$Res, _$RequestsLoadedImpl>
    implements _$$RequestsLoadedImplCopyWith<$Res> {
  __$$RequestsLoadedImplCopyWithImpl(
      _$RequestsLoadedImpl _value, $Res Function(_$RequestsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomingRequests = null,
    Object? outgoingRequests = null,
    Object? isIncomingTab = null,
    Object? processingRequestIds = null,
    Object? actionError = freezed,
  }) {
    return _then(_$RequestsLoadedImpl(
      incomingRequests: null == incomingRequests
          ? _value._incomingRequests
          : incomingRequests // ignore: cast_nullable_to_non_nullable
              as List<FriendRequest>,
      outgoingRequests: null == outgoingRequests
          ? _value._outgoingRequests
          : outgoingRequests // ignore: cast_nullable_to_non_nullable
              as List<FriendRequest>,
      isIncomingTab: null == isIncomingTab
          ? _value.isIncomingTab
          : isIncomingTab // ignore: cast_nullable_to_non_nullable
              as bool,
      processingRequestIds: null == processingRequestIds
          ? _value._processingRequestIds
          : processingRequestIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      actionError: freezed == actionError
          ? _value.actionError
          : actionError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RequestsLoadedImpl implements RequestsLoaded {
  const _$RequestsLoadedImpl(
      {required final List<FriendRequest> incomingRequests,
      required final List<FriendRequest> outgoingRequests,
      required this.isIncomingTab,
      required final Set<String> processingRequestIds,
      this.actionError})
      : _incomingRequests = incomingRequests,
        _outgoingRequests = outgoingRequests,
        _processingRequestIds = processingRequestIds;

  final List<FriendRequest> _incomingRequests;
  @override
  List<FriendRequest> get incomingRequests {
    if (_incomingRequests is EqualUnmodifiableListView)
      return _incomingRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomingRequests);
  }

  final List<FriendRequest> _outgoingRequests;
  @override
  List<FriendRequest> get outgoingRequests {
    if (_outgoingRequests is EqualUnmodifiableListView)
      return _outgoingRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outgoingRequests);
  }

  @override
  final bool isIncomingTab;
  final Set<String> _processingRequestIds;
  @override
  Set<String> get processingRequestIds {
    if (_processingRequestIds is EqualUnmodifiableSetView)
      return _processingRequestIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_processingRequestIds);
  }

  @override
  final String? actionError;

  @override
  String toString() {
    return 'RequestsState.loaded(incomingRequests: $incomingRequests, outgoingRequests: $outgoingRequests, isIncomingTab: $isIncomingTab, processingRequestIds: $processingRequestIds, actionError: $actionError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestsLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._incomingRequests, _incomingRequests) &&
            const DeepCollectionEquality()
                .equals(other._outgoingRequests, _outgoingRequests) &&
            (identical(other.isIncomingTab, isIncomingTab) ||
                other.isIncomingTab == isIncomingTab) &&
            const DeepCollectionEquality()
                .equals(other._processingRequestIds, _processingRequestIds) &&
            (identical(other.actionError, actionError) ||
                other.actionError == actionError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_incomingRequests),
      const DeepCollectionEquality().hash(_outgoingRequests),
      isIncomingTab,
      const DeepCollectionEquality().hash(_processingRequestIds),
      actionError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestsLoadedImplCopyWith<_$RequestsLoadedImpl> get copyWith =>
      __$$RequestsLoadedImplCopyWithImpl<_$RequestsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(incomingRequests, outgoingRequests, isIncomingTab,
        processingRequestIds, actionError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(incomingRequests, outgoingRequests, isIncomingTab,
        processingRequestIds, actionError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(incomingRequests, outgoingRequests, isIncomingTab,
          processingRequestIds, actionError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(RequestsLoaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(RequestsLoaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(RequestsLoaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class RequestsLoaded implements RequestsState {
  const factory RequestsLoaded(
      {required final List<FriendRequest> incomingRequests,
      required final List<FriendRequest> outgoingRequests,
      required final bool isIncomingTab,
      required final Set<String> processingRequestIds,
      final String? actionError}) = _$RequestsLoadedImpl;

  List<FriendRequest> get incomingRequests;
  List<FriendRequest> get outgoingRequests;
  bool get isIncomingTab;
  Set<String> get processingRequestIds;
  String? get actionError;
  @JsonKey(ignore: true)
  _$$RequestsLoadedImplCopyWith<_$RequestsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$RequestsStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'RequestsState.error(message: $message)';
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
    required TResult Function() loading,
    required TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<FriendRequest> incomingRequests,
            List<FriendRequest> outgoingRequests,
            bool isIncomingTab,
            Set<String> processingRequestIds,
            String? actionError)?
        loaded,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(RequestsLoaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(RequestsLoaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(RequestsLoaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements RequestsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
