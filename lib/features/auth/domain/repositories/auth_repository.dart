import 'package:vanish_link/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  AuthUser? get currentUser;
  Stream<AuthUser?> get authStateChanges;
  Future<AuthUser> signIn(String email, String password);
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required String username,
    required String displayName,
  });
  Future<void> signOut();
}

