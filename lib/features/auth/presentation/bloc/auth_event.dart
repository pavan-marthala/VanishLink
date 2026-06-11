part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.authStateChanged({required AuthUser? user}) = _AuthStateChanged;
  const factory AuthEvent.signOutRequested() = _SignOutRequested;
}
