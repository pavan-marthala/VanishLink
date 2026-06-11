import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded({
    required UserProfile profile,
    @Default(false) bool isSaving,
    String? saveError,
    @Default(false) bool saveSuccess,
  }) = ProfileLoaded;
  const factory ProfileState.error(String message) = _Error;
}
