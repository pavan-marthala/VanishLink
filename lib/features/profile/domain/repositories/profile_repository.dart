import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Stream<UserProfile?> watchProfile();
  Future<void> updateProfile({required String displayName, required String status});
}
