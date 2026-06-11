// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendRequestModelImpl _$$FriendRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FriendRequestModelImpl(
      requestId: json['requestId'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$FriendRequestModelImplToJson(
        _$FriendRequestModelImpl instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
