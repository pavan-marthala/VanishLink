import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/auth/domain/repositories/auth_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

export 'sign_up_event.dart';
export 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;
  Timer? _usernameDebounceTimer;

  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState()) {
    on<DisplayNameChanged>((event, emit) {
      final value = event.displayName.trim();
      String? error;
      if (value.isNotEmpty) {
        if (value.length < 2) {
          error = 'Display name must be at least 2 characters';
        } else if (value.length > 50) {
          error = 'Display name must be 50 characters or less';
        }
      }
      emit(state.copyWith(
        displayName: event.displayName,
        displayNameError: error,
      ));
    });

    on<UsernameChanged>((event, emit) {
      final value = event.username.trim().toLowerCase();
      String? error;
      if (value.isNotEmpty) {
        if (value.length < 3) {
          error = 'Username must be at least 3 characters';
        } else if (value.length > 30) {
          error = 'Username must be 30 characters or less';
        } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
          error = 'Only letters, numbers, and underscores allowed';
        }
      }

      _usernameDebounceTimer?.cancel();

      if (error == null && value.length >= 3) {
        emit(state.copyWith(
          username: event.username,
          usernameError: null,
          isUsernameChecking: true,
          isUsernameAvailable: null,
        ));
        _usernameDebounceTimer = Timer(const Duration(milliseconds: 500), () {
          add(const SignUpEvent.checkUsernameUniqueness());
        });
      } else {
        emit(state.copyWith(
          username: event.username,
          usernameError: error,
          isUsernameChecking: false,
          isUsernameAvailable: null,
        ));
      }
    });

    on<CheckUsernameUniqueness>((event, emit) async {
      final usernameLower = state.username.trim().toLowerCase();
      if (usernameLower.length < 3) return;

      emit(state.copyWith(isUsernameChecking: true, isUsernameAvailable: null));

      try {
        final query = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: usernameLower)
            .limit(1)
            .get();

        if (query.docs.isNotEmpty) {
          emit(state.copyWith(
            isUsernameChecking: false,
            isUsernameAvailable: false,
            usernameError: 'Username already taken',
          ));
        } else {
          emit(state.copyWith(
            isUsernameChecking: false,
            isUsernameAvailable: true,
            usernameError: null,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          isUsernameChecking: false,
          isUsernameAvailable: null,
          usernameError: 'Failed to verify username availability',
        ));
      }
    });

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
      final hasMinLength = value.length >= 6 && value.length <= 4096;
      final hasUppercase = value.contains(RegExp(r'[A-Z]'));
      final hasLowercase = value.contains(RegExp(r'[a-z]'));
      final hasNumber = value.contains(RegExp(r'[0-9]'));
      final hasSpecialChar = value.contains(RegExp(r'[^a-zA-Z0-9]'));

      String? error;
      if (value.isNotEmpty) {
        if (!hasMinLength) {
          error = 'Password must be at least 6 characters';
        } else if (!hasUppercase || !hasLowercase || !hasNumber || !hasSpecialChar) {
          error = 'Password does not meet all requirements';
        }
      }

      final strength = _calculatePasswordStrength(
        value,
        hasUppercase,
        hasLowercase,
        hasNumber,
        hasSpecialChar,
      );

      emit(state.copyWith(
        password: event.password,
        passwordError: error,
        hasMinLength: hasMinLength,
        hasUppercase: hasUppercase,
        hasLowercase: hasLowercase,
        hasNumber: hasNumber,
        hasSpecialChar: hasSpecialChar,
        passwordStrength: strength,
      ));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      final value = event.confirmPassword;
      String? error;
      if (value.isNotEmpty && value != state.password) {
        error = 'Passwords do not match';
      }
      emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        confirmPasswordError: error,
      ));
    });

    on<SignUpSubmitted>((event, emit) async {
      // 1. Display Name Validation
      final displayNameTrimmed = state.displayName.trim();
      if (displayNameTrimmed.isEmpty) {
        emit(state.copyWith(displayNameError: 'Display name is required'));
        return;
      }
      if (displayNameTrimmed.length < 2 || displayNameTrimmed.length > 50) {
        emit(state.copyWith(displayNameError: 'Display name must be between 2 and 50 characters'));
        return;
      }
      emit(state.copyWith(displayNameError: null));

      // 2. Username Format Validation
      final usernameLower = state.username.trim().toLowerCase();
      if (usernameLower.isEmpty) {
        emit(state.copyWith(usernameError: 'Username is required'));
        return;
      }
      if (usernameLower.length < 3 || usernameLower.length > 30) {
        emit(state.copyWith(usernameError: 'Username must be between 3 and 30 characters'));
        return;
      }
      final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
      if (!usernameRegex.hasMatch(usernameLower)) {
        emit(state.copyWith(usernameError: 'Only letters, numbers, and underscores allowed'));
        return;
      }
      emit(state.copyWith(usernameError: null));

      // Show loader
      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      // 3. Final Username Uniqueness Validation (Firestore query)
      try {
        final query = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: usernameLower)
            .limit(1)
            .get();
        if (query.docs.isNotEmpty) {
          emit(state.copyWith(
            usernameError: 'Username already taken',
            isUsernameAvailable: false,
            isSubmitting: false,
          ));
          return;
        }
      } catch (e) {
        emit(state.copyWith(
          errorMessage: 'Failed to verify username uniqueness',
          isSubmitting: false,
        ));
        return;
      }

      // 4. Email Format Validation
      final email = state.email.trim();
      if (email.isEmpty) {
        emit(state.copyWith(emailError: 'Email is required', isSubmitting: false));
        return;
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emit(state.copyWith(emailError: 'Enter a valid email address', isSubmitting: false));
        return;
      }
      emit(state.copyWith(emailError: null));

      // 5. Password Policy Validation
      final password = state.password;
      final hasMinLength = password.length >= 6 && password.length <= 4096;
      final hasUppercase = password.contains(RegExp(r'[A-Z]'));
      final hasLowercase = password.contains(RegExp(r'[a-z]'));
      final hasNumber = password.contains(RegExp(r'[0-9]'));
      final hasSpecialChar = password.contains(RegExp(r'[^a-zA-Z0-9]'));

      if (!hasMinLength || !hasUppercase || !hasLowercase || !hasNumber || !hasSpecialChar) {
        emit(state.copyWith(
          passwordError: 'Password does not meet all requirements',
          isSubmitting: false,
        ));
        return;
      }
      emit(state.copyWith(passwordError: null));

      // 6. Confirm Password Validation
      if (state.confirmPassword.isEmpty) {
        emit(state.copyWith(confirmPasswordError: 'Confirm password is required', isSubmitting: false));
        return;
      }
      if (state.confirmPassword != password) {
        emit(state.copyWith(confirmPasswordError: 'Passwords do not match', isSubmitting: false));
        return;
      }
      emit(state.copyWith(confirmPasswordError: null));

      // Sign up action
      try {
        await _authRepository.signUp(
          email: email,
          password: password,
          username: usernameLower,
          displayName: displayNameTrimmed,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } on FirebaseAuthException catch (e) {
        String errorMsg = e.message ?? 'An error occurred';
        if (e.code == 'email-already-in-use') {
          emit(state.copyWith(
            emailError: 'This email address is already registered.',
            isSubmitting: false,
          ));
        } else {
          emit(state.copyWith(
            errorMessage: errorMsg,
            isSubmitting: false,
          ));
        }
      } catch (e) {
        String errorMsg = e.toString().replaceFirst('Exception: ', '');
        if (errorMsg.contains('email-already-in-use') || errorMsg.contains('The email address is already in use')) {
          emit(state.copyWith(
            emailError: 'This email address is already registered.',
            isSubmitting: false,
          ));
        } else {
          emit(state.copyWith(
            errorMessage: errorMsg,
            isSubmitting: false,
          ));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _usernameDebounceTimer?.cancel();
    return super.close();
  }

  String _calculatePasswordStrength(
    String password,
    bool hasUppercase,
    bool hasLowercase,
    bool hasNumber,
    bool hasSpecialChar,
  ) {
    if (password.length < 6) return 'Weak';

    int score = 0;
    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasNumber) score++;
    if (hasSpecialChar) score++;

    if (score <= 2) {
      return 'Weak';
    } else if (score == 3) {
      return 'Medium';
    } else if (score == 4) {
      if (password.length >= 8) {
        return 'Very Strong';
      }
      return 'Strong';
    }
    return 'Weak';
  }
}
