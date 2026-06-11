import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_user_model.freezed.dart';
part 'firestore_user_model.g.dart';

@freezed
class FirestoreUserModel with _$FirestoreUserModel {
  const factory FirestoreUserModel({
    required String userId,
    required String vanishId,
    required String username,
    required String displayName,
    required String email,
    @Default('') String phoneNumber,
    @Default('') String photoUrl,
    @Default('') String publicKey,
    @Default('Available') String status,
    required dynamic createdAt,
    required dynamic lastSeen,
  }) = _FirestoreUserModel;

  factory FirestoreUserModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserModelFromJson(json);
}
