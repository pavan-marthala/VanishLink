import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/theme/app_colors.dart';
import 'package:vanish_link/core/theme/app_typography.dart';
import 'package:vanish_link/core/utils/app_button.dart';
import 'package:vanish_link/core/utils/app_text_field.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/core/utils/dimens.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/core/utils/haptics.dart';
import 'package:vanish_link/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _prevDisplayNameError;
  String? _prevUsernameError;
  String? _prevEmailError;
  String? _prevPasswordError;
  String? _prevConfirmPasswordError;
  String? _prevErrorMessage;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final gradients = context.appGradients;

    return BlocProvider<SignUpBloc>(
      create: (context) => getIt<SignUpBloc>(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage != _prevErrorMessage) {
            AppHaptics.validationError();
            showErrorToast(message: state.errorMessage!);
          }
          if ((state.displayNameError != null && state.displayNameError != _prevDisplayNameError) ||
              (state.usernameError != null && state.usernameError != _prevUsernameError) ||
              (state.emailError != null && state.emailError != _prevEmailError) ||
              (state.passwordError != null && state.passwordError != _prevPasswordError) ||
              (state.confirmPasswordError != null && state.confirmPasswordError != _prevConfirmPasswordError)) {
            AppHaptics.validationError();
          }
          if (state.isSuccess) {
            AppHaptics.success();
            // Registration success: trigger save credentials prompt in OS password managers
            TextInput.finishAutofillContext();
          }

          _prevDisplayNameError = state.displayNameError;
          _prevUsernameError = state.usernameError;
          _prevEmailError = state.emailError;
          _prevPasswordError = state.passwordError;
          _prevConfirmPasswordError = state.confirmPasswordError;
          _prevErrorMessage = state.errorMessage;
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: context.isDark ? gradients.backgroundDark : gradients.backgroundLight,
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimens.veryLargePadding),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.appMediaQuerySmallSizeWidth,
                      ),
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header Logo Icon
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(Dimens.largePadding),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person_add_outlined,
                                  size: 40,
                                  color: colors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimens.veryLargePadding),

                            // Title
                            Center(
                              child: Text(
                                'Create Account',
                                style: typography.headlineLarge.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimens.smallPadding),
                            Center(
                              child: Text(
                                'Sign up to get your unique Vanish ID',
                                style: typography.bodySmall.copyWith(
                                  color: colors.textTertiary,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: Dimens.extraLargePadding),

                            // Form Container
                            Container(
                              padding: const EdgeInsets.all(Dimens.largePadding),
                              decoration: BoxDecoration(
                                color: colors.card,
                                borderRadius: BorderRadius.circular(Dimens.corners),
                                border: Border.all(color: colors.border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Display Name
                                  AppTextField(
                                    labelText: 'Display Name',
                                    hintText: 'Enter public display name',
                                    errorText: state.displayNameError,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.name],
                                    prefixIcon: Icon(
                                      Icons.face_outlined,
                                      color: colors.textTertiary,
                                    ),
                                    onChanged: (val) {
                                      context.read<SignUpBloc>().add(SignUpEvent.displayNameChanged(val));
                                    },
                                  ),
                                  const SizedBox(height: Dimens.largePadding),

                                  // Username
                                  AppTextField(
                                    labelText: 'Username',
                                    hintText: 'Choose a unique username',
                                    errorText: state.usernameError,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.username],
                                    prefixIcon: Icon(
                                      Icons.alternate_email_rounded,
                                      color: colors.textTertiary,
                                    ),
                                    suffixIcon: _buildUsernameSuffix(state, colors),
                                    onChanged: (val) {
                                      context.read<SignUpBloc>().add(SignUpEvent.usernameChanged(val));
                                    },
                                  ),
                                  const SizedBox(height: Dimens.largePadding),

                                  // Email
                                  AppTextField(
                                    labelText: 'Email Address',
                                    hintText: 'Enter your email',
                                    errorText: state.emailError,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.email],
                                    prefixIcon: Icon(
                                      Icons.mail_outline_rounded,
                                      color: colors.textTertiary,
                                    ),
                                    onChanged: (val) {
                                      context.read<SignUpBloc>().add(SignUpEvent.emailChanged(val));
                                    },
                                  ),
                                  const SizedBox(height: Dimens.largePadding),

                                  // Password
                                  AppTextField(
                                    labelText: 'Password',
                                    hintText: 'Create password',
                                    errorText: state.passwordError,
                                    isPassword: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.newPassword],
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: colors.textTertiary,
                                    ),
                                    onChanged: (val) {
                                      context.read<SignUpBloc>().add(SignUpEvent.passwordChanged(val));
                                    },
                                  ),
                                  const SizedBox(height: Dimens.smallPadding),

                                  // Password Requirements Real-time Feedback
                                  _buildPasswordRequirements(state, colors, typography),

                                  // Confirm Password
                                  AppTextField(
                                    labelText: 'Confirm Password',
                                    hintText: 'Confirm password',
                                    errorText: state.confirmPasswordError,
                                    isPassword: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [AutofillHints.newPassword],
                                    prefixIcon: Icon(
                                      Icons.lock_person_outlined,
                                      color: colors.textTertiary,
                                    ),
                                    onChanged: (val) {
                                      context.read<SignUpBloc>().add(SignUpEvent.confirmPasswordChanged(val));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimens.extraLargePadding),

                            // Sign Up Button
                            AppButton(
                              text: state.isSubmitting ? 'Creating Account...' : 'Sign Up',
                              color: colors.primary,
                              isLoading: state.isSubmitting,
                              onPressed: state.isSubmitting
                                  ? null
                                  : () {
                                      context.read<SignUpBloc>().add(const SignUpEvent.signUpSubmitted());
                                    },
                            ),
                            const SizedBox(height: Dimens.largePadding),

                            // Back to Sign In
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: typography.bodySmall.copyWith(
                                    color: colors.textTertiary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.go(AppRoutes.signIn);
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: typography.bodySmall.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget? _buildUsernameSuffix(SignUpState state, AppColors colors) {
    if (state.username.trim().isEmpty) return null;
    if (state.isUsernameChecking) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
          ),
        ),
      );
    }
    if (state.isUsernameAvailable == true && state.usernameError == null) {
      return Icon(
        Icons.check_circle_rounded,
        color: colors.success,
      );
    }
    if (state.isUsernameAvailable == false && state.usernameError != null) {
      return Icon(
        Icons.cancel_rounded,
        color: colors.error,
      );
    }
    return null;
  }

  Widget _buildPasswordRequirements(SignUpState state, AppColors colors, AppTypography typography) {
    Widget requirementRow(String label, bool isMet) {
      return Row(
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            color: isMet ? colors.success : colors.textTertiary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: typography.bodySmall.copyWith(
                color: isMet ? colors.textPrimary : colors.textTertiary,
                fontWeight: isMet ? FontWeight.bold : FontWeight.normal,
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      );
    }

    Widget? strengthBar;
    if (state.password.isNotEmpty) {
      final strength = state.passwordStrength;
      Color barColor;
      int activeSegments;

      switch (strength) {
        case 'Medium':
          barColor = colors.warning;
          activeSegments = 2;
          break;
        case 'Strong':
          barColor = colors.successDark;
          activeSegments = 3;
          break;
        case 'Very Strong':
          barColor = colors.success;
          activeSegments = 4;
          break;
        case 'Weak':
        default:
          barColor = colors.error;
          activeSegments = 1;
          break;
      }

      strengthBar = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Password Strength:',
                style: typography.labelSmall.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                strength,
                style: typography.labelSmall.copyWith(
                  color: barColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(4, (index) {
              final isActive = index < activeSegments;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index < 3 ? 4 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? barColor : (context.isDark ? colors.border : colors.gray4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: Dimens.largePadding),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: Dimens.smallPadding, bottom: Dimens.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: use_null_aware_elements
          if (strengthBar != null) strengthBar,
          Text(
            'Password Requirements:',
            style: typography.labelSmall.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          requirementRow('Minimum 6 characters', state.hasMinLength),
          const SizedBox(height: 4),
          requirementRow('At least one uppercase letter (A-Z)', state.hasUppercase),
          const SizedBox(height: 4),
          requirementRow('At least one lowercase letter (a-z)', state.hasLowercase),
          const SizedBox(height: 4),
          requirementRow('At least one numeric digit (0-9)', state.hasNumber),
          const SizedBox(height: 4),
          requirementRow('At least one special character (e.g. @, #, \$, _)', state.hasSpecialChar),
        ],
      ),
    );
  }
}
