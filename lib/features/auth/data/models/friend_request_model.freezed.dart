// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) {
  return _FriendRequestModel.fromJson(json);
}

/// @nodoc
mixin _$FriendRequestModel {
  String get requestId => throw _privateConstructorUsedError;
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  dynamic get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FriendRequestModelCopyWith<FriendRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestModelCopyWith<$Res> {
  factory $FriendRequestModelCopyWith(
          FriendRequestModel value, $Res Function(FriendRequestModel) then) =
      _$FriendRequestModelCopyWithImpl<$Res, FriendRequestModel>;
  @useResult
  $Res call(
      {String requestId,
      String fromUserId,
      String toUserId,
      String status,
      dynamic createdAt,
      dynamic updatedAt});
}

/// @nodoc
class _$FriendRequestModelCopyWithImpl<$Res, $Val extends FriendRequestModel>
    implements $FriendRequestModelCopyWith<$Res> {
  _$FriendRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendRequestModelImplCopyWith<$Res>
    implements $FriendRequestModelCopyWith<$Res> {
  factory _$$FriendRequestModelImplCopyWith(_$FriendRequestModelImpl value,
          $Res Function(_$FriendRequestModelImpl) then) =
      __$$FriendRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String requestId,
      String fromUserId,
      String toUserId,
      String status,
      dynamic createdAt,
      dynamic updatedAt});
}

/// @nodoc
class __$$FriendRequestModelImplCopyWithImpl<$Res>
    extends _$FriendRequestModelCopyWithImpl<$Res, _$FriendRequestModelImpl>
    implements _$$FriendRequestModelImplCopyWith<$Res> {
  __$$FriendRequestModelImplCopyWithImpl(_$FriendRequestModelImpl _value,
      $Res Function(_$FriendRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$FriendRequestModelImpl(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendRequestModelImpl implements _FriendRequestModel {
  const _$FriendRequestModelImpl(
      {required this.requestId,
      required this.fromUserId,
      required this.toUserId,
      this.status = 'pending',
      required this.createdAt,
      required this.updatedAt});

  factory _$FriendRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRequestModelImplFromJson(json);

  @override
  final String requestId;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  @JsonKey()
  final String status;
  @override
  final dynamic createdAt;
  @override
  final dynamic updatedAt;

  @override
  String toString() {
    return 'FriendRequestModel(requestId: $requestId, fromUserId: $fromUserId, toUserId: $toUserId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestModelImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requestId,
      fromUserId,
      toUserId,
      status,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestModelImplCopyWith<_$FriendRequestModelImpl> get copyWith =>
      __$$FriendRequestModelImplCopyWithImpl<_$FriendRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRequestModelImplToJson(
      this,
    );
  }
}

abstract class _FriendRequestModel implements FriendRequestModel {
  const factory _FriendRequestModel(
      {required final String requestId,
      required final String fromUserId,
      required final String toUserId,
      final String status,
      required final dynamic createdAt,
      required final dynamic updatedAt}) = _$FriendRequestModelImpl;

  factory _FriendRequestModel.fromJson(Map<String, dynamic> json) =
      _$FriendRequestModelImpl.fromJson;

  @override
  String get requestId;
  @override
  String get fromUserId;
  @override
  String get toUserId;
  @override
  String get status;
  @override
  dynamic get createdAt;
  @override
  dynamic get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$FriendRequestModelImplCopyWith<_$FriendRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
