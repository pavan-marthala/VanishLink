import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/app_button.dart';
import 'package:vanish_link/core/utils/app_text_field.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/core/utils/dimens.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/core/utils/haptics.dart';
import 'package:vanish_link/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _prevEmailError;
  String? _prevPasswordError;
  String? _prevErrorMessage;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final gradients = context.appGradients;

    return BlocProvider<SignInBloc>(
      create: (context) => getIt<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage != _prevErrorMessage) {
            AppHaptics.validationError();
            showErrorToast(message: state.errorMessage!);
          }
          if ((state.emailError != null && state.emailError != _prevEmailError) ||
              (state.passwordError != null && state.passwordError != _prevPasswordError)) {
            AppHaptics.validationError();
          }
          if (state.isSuccess) {
            AppHaptics.success();
            TextInput.finishAutofillContext();
          }

          _prevEmailError = state.emailError;
          _prevPasswordError = state.passwordError;
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
                                  Icons.lock_outline_rounded,
                                  size: 40,
                                  color: colors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimens.veryLargePadding),

                            // Welcome Texts
                            Center(
                              child: Text(
                                'Welcome Back',
                                style: typography.headlineLarge.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimens.smallPadding),
                            Center(
                              child: Text(
                                'Sign in to access secure vanishing links',
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
                                  // Email Field
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
                                      context.read<SignInBloc>().add(SignInEvent.emailChanged(val));
                                    },
                                  ),
                                  const SizedBox(height: Dimens.largePadding),

                                  // Password Field
                                  AppTextField(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    errorText: state.passwordError,
                                    isPassword: true,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [AutofillHints.password],
                                    prefixIcon: Icon(
                                      Icons.lock_open_outlined,
                                      color: colors.textTertiary,
                                    ),
                                    onChanged: (val) {
                                      context.read<SignInBloc>().add(SignInEvent.passwordChanged(val));
                                    },
                                  ),
                                  const SizedBox(height: Dimens.mediumPadding),

                                  // Forgot Password Text Button
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Will implement forgot password in future updates
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        'Forgot Password?',
                                        style: typography.labelMedium.copyWith(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimens.extraLargePadding),

                            // Sign In Button
                            AppButton(
                              text: state.isSubmitting ? 'Signing In...' : 'Sign In',
                              color: colors.primary,
                              isLoading: state.isSubmitting,
                              onPressed: state.isSubmitting
                                  ? null
                                  : () {
                                      context.read<SignInBloc>().add(const SignInEvent.signInSubmitted());
                                    },
                            ),
                            const SizedBox(height: Dimens.largePadding),

                            // Sign Up Option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: typography.bodySmall.copyWith(
                                      color: colors.textTertiary,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.go(AppRoutes.signUp);
                                    },
                                    child: Text(
                                      'Sign Up',
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
}
