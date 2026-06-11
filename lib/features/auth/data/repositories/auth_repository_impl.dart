import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:vanish_link/features/auth/domain/entities/auth_user.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';

extension FirebaseUserMapper on User {
  AuthUser toDomain() {
    return AuthUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoURL,
    );
  }
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  AuthUser? get currentUser => _remoteDataSource.currentUser?.toDomain();

  @override
  Stream<AuthUser?> get authStateChanges =>
      _remoteDataSource.authStateChanges.map((user) => user?.toDomain());

  @override
  Future<AuthUser> signIn(String email, String password) async {
    final user = await _remoteDataSource.signIn(email, password);
    return user.toDomain();
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required String username,
    required String displayName,
  }) async {
    User? firebaseUser;
    try {
      firebaseUser = await _remoteDataSource.signUp(email, password);
      
      final vanishId = _generateVanishId();

      await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
        'userId': firebaseUser.uid,
        'vanishId': vanishId,
        'username': username,
        'displayName': displayName,
        'email': email,
        'phoneNumber': '',
        'photoUrl': '',
        'publicKey': '',
        'status': 'Available',
        'createdAt': FieldValue.serverTimestamp(),
        'lastSeen': FieldValue.serverTimestamp(),
      });

      return firebaseUser.toDomain();
    } catch (e) {
      if (firebaseUser != null) {
        try {
          await firebaseUser.delete();
        } catch (_) {
          // Silent catch on rollback delete failure
        }
      }
      rethrow;
    }
  }

  @override
  Future<void> signOut() => _remoteDataSource.signOut();

  String _generateVanishId() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final suffix = String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
    return 'vanish_$suffix';
  }
}

