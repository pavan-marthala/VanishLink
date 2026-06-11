// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreUserModelImpl _$$FirestoreUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirestoreUserModelImpl(
      userId: json['userId'] as String,
      vanishId: json['vanishId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      photoUrl: json['photoUrl'] as String? ?? '',
      publicKey: json['publicKey'] as String? ?? '',
      status: json['status'] as String? ?? 'Available',
      createdAt: json['createdAt'],
      lastSeen: json['lastSeen'],
    );

Map<String, dynamic> _$$FirestoreUserModelImplToJson(
        _$FirestoreUserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'vanishId': instance.vanishId,
      'username': instance.username,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'publicKey': instance.publicKey,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'lastSeen': instance.lastSeen,
    };
