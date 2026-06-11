// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactModelImpl _$$ContactModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactModelImpl(
      userId: json['userId'] as String,
      contactUserId: json['contactUserId'] as String,
      createdAt: json['createdAt'],
      isBlocked: json['isBlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$ContactModelImplToJson(_$ContactModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'contactUserId': instance.contactUserId,
      'createdAt': instance.createdAt,
      'isBlocked': instance.isBlocked,
    };
