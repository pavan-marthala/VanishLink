import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';
import 'package:vanish_link/features/request/domain/repositories/request_repository.dart';

class RequestRepositoryImpl implements RequestRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  RequestRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<FriendRequest>> watchIncomingRequests() {
    final currentUserId = _firebaseAuth.currentUser?.uid ?? '';
    if (currentUserId.isEmpty) return Stream.value(const []);

    return _firestore
        .collection('friend_requests')
        .where('toUserId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
          final requests = <FriendRequest>[];
          for (final doc in snapshot.docs) {
            final data = doc.data();
            final fromUserId = data['fromUserId'] as String? ?? '';

            // Fetch sender user profile
            final userDoc = await _firestore.collection('users').doc(fromUserId).get();
            UserProfile? senderProfile;
            if (userDoc.exists) {
              final userData = userDoc.data();
              if (userData != null) {
                senderProfile = UserProfile(
                  userId: userData['userId'] as String? ?? '',
                  vanishId: userData['vanishId'] as String? ?? '',
                  username: userData['username'] as String? ?? '',
                  displayName: userData['displayName'] as String? ?? '',
                  photoUrl: userData['photoUrl'] as String? ?? '',
                  status: userData['status'] as String? ?? 'Available',
                );
              }
            }

            requests.add(FriendRequest(
              requestId: doc.id,
              fromUserId: fromUserId,
              toUserId: data['toUserId'] as String? ?? '',
              status: data['status'] as String? ?? 'pending',
              createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
              updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
              senderProfile: senderProfile,
            ));
          }
          return requests;
        });
  }

  @override
  Stream<List<FriendRequest>> watchOutgoingRequests() {
    final currentUserId = _firebaseAuth.currentUser?.uid ?? '';
    if (currentUserId.isEmpty) return Stream.value(const []);

    return _firestore
        .collection('friend_requests')
        .where('fromUserId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .asyncMap((snapshot) async {
          final requests = <FriendRequest>[];
          for (final doc in snapshot.docs) {
            final data = doc.data();
            final toUserId = data['toUserId'] as String? ?? '';

            // Fetch receiver user profile
            final userDoc = await _firestore.collection('users').doc(toUserId).get();
            UserProfile? receiverProfile;
            if (userDoc.exists) {
              final userData = userDoc.data();
              if (userData != null) {
                receiverProfile = UserProfile(
                  userId: userData['userId'] as String? ?? '',
                  vanishId: userData['vanishId'] as String? ?? '',
                  username: userData['username'] as String? ?? '',
                  displayName: userData['displayName'] as String? ?? '',
                  photoUrl: userData['photoUrl'] as String? ?? '',
                  status: userData['status'] as String? ?? 'Available',
                );
              }
            }

            requests.add(FriendRequest(
              requestId: doc.id,
              fromUserId: data['fromUserId'] as String? ?? '',
              toUserId: toUserId,
              status: data['status'] as String? ?? 'pending',
              createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
              updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
              receiverProfile: receiverProfile,
            ));
          }
          return requests;
        });
  }

  @override
  Future<void> acceptRequest(
    String requestId,
    String fromUserId,
    String toUserId,
  ) async {
    final batch = _firestore.batch();

    // 1. Update friend request status to accepted
    final requestRef = _firestore.collection('friend_requests').doc(requestId);
    batch.update(requestRef, {
      'status': 'accepted',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    // 2. Create A accepts B contact record
    final contactRef1 = _firestore.collection('contacts').doc('${toUserId}_$fromUserId');
    batch.set(contactRef1, {
      'userId': toUserId,
      'contactUserId': fromUserId,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 3. Create B accepts A contact record
    final contactRef2 = _firestore.collection('contacts').doc('${fromUserId}_$toUserId');
    batch.set(contactRef2, {
      'userId': fromUserId,
      'contactUserId': toUserId,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  @override
  Future<void> declineRequest(String requestId) async {
    await _firestore.collection('friend_requests').doc(requestId).update({
      'status': 'declined',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    await _firestore.collection('friend_requests').doc(requestId).update({
      'status': 'cancelled',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
