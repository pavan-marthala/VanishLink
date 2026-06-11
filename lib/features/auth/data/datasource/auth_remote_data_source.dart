import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSourceImpl(this._firebaseAuth);

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User> signIn(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) {
      throw Exception('Sign in failed: Firebase user is null');
    }
    return credential.user!;
  }

  @override
  Future<User> signUp(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) {
      throw Exception('Sign up failed: Firebase user is null');
    }
    return credential.user!;
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}

