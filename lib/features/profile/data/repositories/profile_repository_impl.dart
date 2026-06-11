import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  ProfileRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<UserProfile?> watchProfile() {
    final currentUserId = _firebaseAuth.currentUser?.uid;
    if (currentUserId == null || currentUserId.isEmpty) {
      return Stream.value(null);
    }
    return _firestore
        .collection('users')
        .doc(currentUserId)
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists) return null;
          final data = snapshot.data();
          if (data == null) return null;
          return UserProfile(
            userId: data['userId'] as String? ?? '',
            vanishId: data['vanishId'] as String? ?? '',
            username: data['username'] as String? ?? '',
            displayName: data['displayName'] as String? ?? '',
            photoUrl: data['photoUrl'] as String? ?? '',
            status: data['status'] as String? ?? 'Available',
          );
        });
  }

  @override
  Future<void> updateProfile({
    required String displayName,
    required String status,
  }) async {
    final currentUserId = _firebaseAuth.currentUser?.uid;
    if (currentUserId == null || currentUserId.isEmpty) {
      throw Exception('User is not logged in');
    }
    await _firestore.collection('users').doc(currentUserId).update({
      'displayName': displayName,
      'status': status,
    });
  }
}
