import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String displayName,
    @Default('') String username,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSuccess,
    String? errorMessage,
    
    // Field-specific validation errors
    String? displayNameError,
    String? usernameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,

    // Real-time password requirement flags
    @Default(false) bool hasMinLength,
    @Default(false) bool hasUppercase,
    @Default(false) bool hasLowercase,
    @Default(false) bool hasNumber,
    @Default(false) bool hasSpecialChar,
    @Default('Weak') String passwordStrength,

    // Real-time username check flags
    @Default(false) bool isUsernameChecking,
    bool? isUsernameAvailable,
  }) = _SignUpState;
}
