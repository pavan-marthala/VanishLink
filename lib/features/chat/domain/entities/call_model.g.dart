// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallModelImpl _$$CallModelImplFromJson(Map<String, dynamic> json) =>
    _$CallModelImpl(
      callId: json['callId'] as String,
      callerId: json['callerId'] as String,
      receiverId: json['receiverId'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
      acceptedAt: (json['acceptedAt'] as num?)?.toInt(),
      endedAt: (json['endedAt'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CallModelImplToJson(_$CallModelImpl instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'callerId': instance.callerId,
      'receiverId': instance.receiverId,
      'type': instance.type,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'acceptedAt': instance.acceptedAt,
      'endedAt': instance.endedAt,
      'duration': instance.duration,
    };
