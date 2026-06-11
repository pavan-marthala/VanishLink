import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = Started;
  const factory ProfileEvent.profileUpdated(UserProfile? profile) = ProfileUpdated;
  const factory ProfileEvent.editProfileRequested({
    required String displayName,
    required String status,
  }) = EditProfileRequested;
}
