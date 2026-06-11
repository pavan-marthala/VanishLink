import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/profile/domain/repositories/profile_repository.dart';
import 'package:vanish_link/features/profile/presentation/bloc/profile_bloc.dart';

class FakeProfileRepository implements ProfileRepository {
  final StreamController<UserProfile?> _profileController = StreamController<UserProfile?>.broadcast();

  bool updateCalled = false;
  String? updatedDisplayName;
  String? updatedStatus;
  bool shouldThrowError = false;

  void emitProfile(UserProfile? profile) {
    _profileController.add(profile);
  }

  @override
  Stream<UserProfile?> watchProfile() => _profileController.stream;

  @override
  Future<void> updateProfile({required String displayName, required String status}) async {
    if (shouldThrowError) throw Exception('Update profile failed');
    updateCalled = true;
    updatedDisplayName = displayName;
    updatedStatus = status;
  }

  void dispose() {
    _profileController.close();
  }
}

void main() {
  group('ProfileBloc Tests', () {
    late FakeProfileRepository fakeRepository;
    late ProfileBloc profileBloc;

    final myProfile = const UserProfile(
      userId: 'my_user_id',
      vanishId: 'vanish_me123',
      username: 'myself',
      displayName: 'My Display Name',
      photoUrl: '',
      status: 'Available',
    );

    setUp(() {
      fakeRepository = FakeProfileRepository();
      profileBloc = ProfileBloc(profileRepository: fakeRepository);
    });

    tearDown(() {
      profileBloc.close();
      fakeRepository.dispose();
    });

    test('Initial state is ProfileState.initial()', () {
      expect(profileBloc.state, const ProfileState.initial());
    });

    test('Started event emits loading state and listens to stream', () async {
      profileBloc.add(const ProfileEvent.started());
      
      await Future.delayed(const Duration(milliseconds: 10));
      expect(profileBloc.state, const ProfileState.loading());

      fakeRepository.emitProfile(myProfile);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(
        profileBloc.state,
        ProfileState.loaded(profile: myProfile),
      );
    });

    test('EditProfileRequested successful state transitions', () async {
      // 1. Get into loaded state
      profileBloc.add(const ProfileEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitProfile(myProfile);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Request profile edit
      profileBloc.add(const ProfileEvent.editProfileRequested(
        displayName: 'New Name',
        status: 'Offline Mode',
      ));

      // Should transition to isSaving: true
      await Future.microtask(() {});
      profileBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.isSaving, isTrue);
          expect(s.saveSuccess, isFalse);
          expect(s.saveError, isNull);
        },
      );

      // Wait for repository call to complete
      await Future.delayed(const Duration(milliseconds: 10));

      expect(fakeRepository.updateCalled, isTrue);
      expect(fakeRepository.updatedDisplayName, 'New Name');
      expect(fakeRepository.updatedStatus, 'Offline Mode');

      // Should transition to isSaving: false, saveSuccess: true
      profileBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.isSaving, isFalse);
          expect(s.saveSuccess, isTrue);
        },
      );
    });

    test('EditProfileRequested failure sets saveError', () async {
      fakeRepository.shouldThrowError = true;

      // 1. Get into loaded state
      profileBloc.add(const ProfileEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitProfile(myProfile);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Request profile edit
      profileBloc.add(const ProfileEvent.editProfileRequested(
        displayName: 'New Name',
        status: 'Offline Mode',
      ));

      // Wait for repository call to fail
      await Future.delayed(const Duration(milliseconds: 10));

      profileBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.isSaving, isFalse);
          expect(s.saveSuccess, isFalse);
          expect(s.saveError, isNotNull);
        },
      );
    });
  });
}
