import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/core/utils/app_button.dart';
import 'package:vanish_link/core/utils/app_text_field.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/features/profile/presentation/bloc/profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const _EditProfileScreenContent(),
    );
  }
}

class _EditProfileScreenContent extends StatefulWidget {
  const _EditProfileScreenContent();

  @override
  State<_EditProfileScreenContent> createState() => _EditProfileScreenContentState();
}

class _EditProfileScreenContentState extends State<_EditProfileScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  bool _initialized = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      context.read<ProfileBloc>().add(
            ProfileEvent.editProfileRequested(
              displayName: _displayNameController.text,
              status: _statusController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.card,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Edit Profile',
          style: typography.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colors.border.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          state.mapOrNull(
            loaded: (s) {
              if (s.saveSuccess) {
                showSuccessToast(message: 'Profile updated successfully!');
                context.pop();
              }
              if (s.saveError != null) {
                showErrorToast(message: 'Failed to update profile: ${s.saveError}');
              }
            },
          );
        },
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (s) => Center(
              child: Text(
                s.message,
                style: typography.bodyMedium.copyWith(color: colors.error),
              ),
            ),
            loaded: (s) {
              if (!_initialized) {
                _displayNameController.text = s.profile.displayName;
                _statusController.text = s.profile.status;
                _initialized = true;
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section header for editable fields
                      Text(
                        'Public Information',
                        style: typography.labelSmall.copyWith(
                          color: colors.textTertiary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Display Name Field
                      AppTextField(
                        controller: _displayNameController,
                        labelText: 'Display Name',
                        hintText: 'Enter your display name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Display name is required';
                          }
                          final trimmed = value.trim();
                          if (trimmed.length < 2) {
                            return 'Display name must be at least 2 characters';
                          }
                          if (trimmed.length > 50) {
                            return 'Display name must be at most 50 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Status Field
                      AppTextField(
                        controller: _statusController,
                        labelText: 'Status Banner',
                        hintText: 'What is on your mind?',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Status is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Section header for read-only fields
                      Text(
                        'Read-only Credentials',
                        style: typography.labelSmall.copyWith(
                          color: colors.textTertiary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Read-only parameters cards
                      _buildReadOnlyTile(
                        label: 'Vanish ID',
                        value: s.profile.vanishId,
                        icon: Icons.vpn_key_rounded,
                      ),
                      const SizedBox(height: 12),
                      _buildReadOnlyTile(
                        label: 'User ID',
                        value: s.profile.userId,
                        icon: Icons.fingerprint_rounded,
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          text: s.isSaving ? 'Saving Changes...' : 'Save Changes',
                          color: colors.primary,
                          isLoading: s.isSaving,
                          onPressed: s.isSaving ? null : () => _save(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildReadOnlyTile({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Builder(builder: (context) {
      final colors = context.appColors;
      final typography = context.appTypography;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfaceDark.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.border.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: colors.textTertiary,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: typography.bodySmall.copyWith(
                      color: colors.textTertiary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: typography.bodyMedium.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.lock_rounded,
              color: colors.textTertiary,
              size: 16,
            ),
          ],
        ),
      );
    });
  }
}
