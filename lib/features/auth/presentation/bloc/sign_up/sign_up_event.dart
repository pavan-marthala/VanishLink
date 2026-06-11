import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.freezed.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.displayNameChanged(String displayName) = DisplayNameChanged;
  const factory SignUpEvent.usernameChanged(String username) = UsernameChanged;
  const factory SignUpEvent.emailChanged(String email) = EmailChanged;
  const factory SignUpEvent.passwordChanged(String password) = PasswordChanged;
  const factory SignUpEvent.confirmPasswordChanged(String confirmPassword) = ConfirmPasswordChanged;
  const factory SignUpEvent.signUpSubmitted() = SignUpSubmitted;
  const factory SignUpEvent.checkUsernameUniqueness() = CheckUsernameUniqueness;
}
