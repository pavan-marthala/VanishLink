import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/utils/device_identifier_provider.dart';
import 'package:vanish_link/features/auth/domain/entities/auth_user.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';

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
          final uid = _authRepository.currentUser?.uid;
          if (uid != null) {
            try {
              final deviceIdProvider = getIt<DeviceIdentifierProvider>();
              final presenceRepo = getIt<PresenceRepository>();
              final deviceId = await deviceIdProvider.getIdentifier();
              await presenceRepo.removeDevicePushToken(uid, deviceId);
              // ignore: avoid_print
              print('[DIAG-PUSH] push token removed successfully on logout for user: $uid, device: $deviceId');
            } catch (err) {
              // ignore: avoid_print
              print('[DIAG-PUSH] push token cleanup failed on logout: $err');
            }
          }
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
