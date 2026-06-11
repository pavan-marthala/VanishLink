import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

export 'sign_in_event.dart';
export 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;

  SignInBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignInState()) {
    on<EmailChanged>((event, emit) {
      final value = event.email.trim();
      String? error;
      if (value.isNotEmpty) {
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          error = 'Enter a valid email address';
        }
      }
      emit(state.copyWith(
        email: event.email,
        emailError: error,
      ));
    });

    on<PasswordChanged>((event, emit) {
      final value = event.password;
      String? error;
      if (value.isNotEmpty && value.length < 6) {
        error = 'Password must be at least 6 characters';
      }
      emit(state.copyWith(
        password: event.password,
        passwordError: error,
      ));
    });

    on<SignInSubmitted>((event, emit) async {
      // 1. Email validation
      final email = state.email.trim();
      if (email.isEmpty) {
        emit(state.copyWith(emailError: 'Email is required'));
        return;
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emit(state.copyWith(emailError: 'Enter a valid email address'));
        return;
      }
      emit(state.copyWith(emailError: null));

      // 2. Password validation
      final password = state.password;
      if (password.isEmpty) {
        emit(state.copyWith(passwordError: 'Password is required'));
        return;
      }
      emit(state.copyWith(passwordError: null));

      // Show loader
      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      try {
        await _authRepository.signIn(email, password);
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } on FirebaseAuthException catch (e) {
        String errorMsg = 'Invalid email or password';
        if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
          errorMsg = 'Invalid email or password. Please try again.';
        } else if (e.code == 'user-disabled') {
          errorMsg = 'This user account has been disabled.';
        } else if (e.code == 'too-many-requests') {
          errorMsg = 'Too many requests. Please try again later.';
        } else if (e.message != null) {
          errorMsg = e.message!;
        }
        emit(state.copyWith(
          errorMessage: errorMsg,
          isSubmitting: false,
        ));
      } catch (e) {
        emit(state.copyWith(
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
          isSubmitting: false,
        ));
      }
    });
  }
}
