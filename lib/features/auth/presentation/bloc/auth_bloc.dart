import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/auth/domain/entities/auth_user.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<AuthUser?>? _authStateSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        started: (e) async {
          await _authStateSubscription?.cancel();
          
          final user = _authRepository.currentUser;
          if (user != null) {
            emit(AuthState.authenticated(user: user));
          } else {
            emit(const AuthState.unauthenticated());
          }

          _authStateSubscription = _authRepository.authStateChanges.listen((user) {
            add(AuthEvent.authStateChanged(user: user));
          });
        },
        authStateChanged: (e) async {
          if (e.user != null) {
            emit(AuthState.authenticated(user: e.user!));
          } else {
            emit(const AuthState.unauthenticated());
          }
        },
        signOutRequested: (e) async {
          await _authRepository.signOut();
        },
      );
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
