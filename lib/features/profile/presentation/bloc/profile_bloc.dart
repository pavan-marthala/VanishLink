import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/profile/domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

export 'profile_event.dart';
export 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  StreamSubscription<UserProfile?>? _profileSub;

  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const ProfileState.initial()) {
    
    on<Started>((event, emit) {
      emit(const ProfileState.loading());
      _profileSub?.cancel();
      _profileSub = _profileRepository.watchProfile().listen(
        (profile) => add(ProfileEvent.profileUpdated(profile)),
        onError: (e) => emit(ProfileState.error(e.toString())),
      );
    });

    on<ProfileUpdated>((event, emit) {
      if (event.profile == null) {
        emit(const ProfileState.error('Failed to load user profile.'));
      } else {
        emit(ProfileState.loaded(profile: event.profile!));
      }
    });

    on<EditProfileRequested>((event, emit) async {
      final currentState = state;
      if (currentState is! ProfileLoaded) return;

      emit(currentState.copyWith(isSaving: true, saveError: null, saveSuccess: false));

      try {
        await _profileRepository.updateProfile(
          displayName: event.displayName.trim(),
          status: event.status.trim(),
        );
        
        final resultsState = state;
        if (resultsState is ProfileLoaded) {
          emit(resultsState.copyWith(isSaving: false, saveSuccess: true));
        }
      } catch (e) {
        final resultsState = state;
        if (resultsState is ProfileLoaded) {
          emit(resultsState.copyWith(
            isSaving: false,
            saveError: e.toString(),
          ));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _profileSub?.cancel();
    return super.close();
  }
}
