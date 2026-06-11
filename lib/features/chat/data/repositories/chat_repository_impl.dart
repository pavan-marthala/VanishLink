import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  ChatRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<UserProfile>> watchContacts() {
    final currentUserId = _firebaseAuth.currentUser?.uid;
    if (currentUserId == null || currentUserId.isEmpty) {
      return Stream.value(const []);
    }

    return _firestore
        .collection('contacts')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
          final contacts = <UserProfile>[];
          for (final doc in snapshot.docs) {
            final data = doc.data();
            final contactUserId = data['contactUserId'] as String? ?? '';
            if (contactUserId.isEmpty) continue;

            final userDoc = await _firestore.collection('users').doc(contactUserId).get();
            if (userDoc.exists) {
              final userData = userDoc.data();
              if (userData != null) {
                contacts.add(UserProfile(
                  userId: userData['userId'] as String? ?? '',
                  vanishId: userData['vanishId'] as String? ?? '',
                  username: userData['username'] as String? ?? '',
                  displayName: userData['displayName'] as String? ?? '',
                  photoUrl: userData['photoUrl'] as String? ?? '',
                  status: userData['status'] as String? ?? 'Available',
                ));
              }
            }
          }
          return contacts;
        });
  }
}
