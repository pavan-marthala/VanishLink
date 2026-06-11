import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  DiscoverRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<List<UserProfile>> searchUsers({
    required String query,
  }) async {
    final currentUserId = _firebaseAuth.currentUser?.uid ?? '';
    final searchLower = query.trim().toLowerCase();
    if (searchLower.isEmpty) return const [];

    // Format vanishId query term
    String searchVanishId = query.trim();
    if (searchVanishId.toLowerCase().startsWith('vanish_')) {
      final suffix = searchVanishId.substring(7).toUpperCase();
      searchVanishId = 'vanish_$suffix';
    } else {
      searchVanishId = 'vanish_${searchVanishId.toUpperCase()}';
    }

    try {
      // Execute username and vanishId queries in parallel
      final futures = await Future.wait([
        _firestore
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: searchLower)
            .where('username', isLessThanOrEqualTo: '$searchLower\uf8ff')
            .limit(30)
            .get(),
        _firestore
            .collection('users')
            .where('vanishId', isGreaterThanOrEqualTo: searchVanishId)
            .where('vanishId', isLessThanOrEqualTo: '$searchVanishId\uf8ff')
            .limit(30)
            .get(),
      ]);

      final usernameDocs = futures[0].docs;
      final vanishDocs = futures[1].docs;

      // Merge and deduplicate documents by userId
      final Map<String, DocumentSnapshot> mergedDocs = {};

      for (final doc in usernameDocs) {
        final data = doc.data() as Map<String, dynamic>?;
        final userId = data?['userId'] as String?;
        if (userId != null && userId != currentUserId) {
          mergedDocs[userId] = doc;
        }
      }

      for (final doc in vanishDocs) {
        final data = doc.data() as Map<String, dynamic>?;
        final userId = data?['userId'] as String?;
        if (userId != null && userId != currentUserId) {
          mergedDocs[userId] = doc;
        }
      }

      // Map to UserProfile list
      return mergedDocs.values.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserProfile(
          userId: data['userId'] as String? ?? '',
          vanishId: data['vanishId'] as String? ?? '',
          username: data['username'] as String? ?? '',
          displayName: data['displayName'] as String? ?? '',
          photoUrl: data['photoUrl'] as String? ?? '',
          status: data['status'] as String? ?? 'Available',
        );
      }).toList();
    } catch (e) {
      return const [];
    }
  }

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;

      final data = doc.data() as Map<String, dynamic>;
      return UserProfile(
        userId: data['userId'] as String? ?? '',
        vanishId: data['vanishId'] as String? ?? '',
        username: data['username'] as String? ?? '',
        displayName: data['displayName'] as String? ?? '',
        photoUrl: data['photoUrl'] as String? ?? '',
        status: data['status'] as String? ?? 'Available',
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<FriendshipStatus> checkFriendshipStatus({
    required String targetUserId,
  }) async {
    final currentUserId = _firebaseAuth.currentUser?.uid ?? '';
    if (currentUserId.isEmpty) return FriendshipStatus.none;
    if (currentUserId == targetUserId) {
      return FriendshipStatus.none;
    }

    // 1. Check if they are already contacts using O(1) sorted composite doc key
    final sortedIds = [currentUserId, targetUserId]..sort();
    final contactId = sortedIds.join('_');

    try {
      final contactDoc = await _firestore.collection('contacts').doc(contactId).get();
      if (contactDoc.exists) {
        return FriendshipStatus.contacts;
      }

      // 2. Check pending outgoing request
      final outgoing = await _firestore
          .collection('friend_requests')
          .where('fromUserId', isEqualTo: currentUserId)
          .where('toUserId', isEqualTo: targetUserId)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (outgoing.docs.isNotEmpty) {
        return FriendshipStatus.pendingSent;
      }

      // 3. Check pending incoming request
      final incoming = await _firestore
          .collection('friend_requests')
          .where('fromUserId', isEqualTo: targetUserId)
          .where('toUserId', isEqualTo: currentUserId)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (incoming.docs.isNotEmpty) {
        return FriendshipStatus.pendingReceived;
      }

      return FriendshipStatus.none;
    } catch (e) {
      return FriendshipStatus.none;
    }
  }

  @override
  Future<void> sendFriendRequest({
    required String targetUserId,
  }) async {
    final currentUserId = _firebaseAuth.currentUser?.uid ?? '';
    if (currentUserId.isEmpty) {
      throw Exception('User is not authenticated.');
    }
    if (currentUserId == targetUserId) {
      throw Exception('You cannot send a friend request to yourself.');
    }

    final docRef = _firestore.collection('friend_requests').doc();
    await docRef.set({
      'requestId': docRef.id,
      'fromUserId': currentUserId,
      'toUserId': targetUserId,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
