import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/services/permission_manager.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/app_toast.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PermissionManager _permissionManager = getIt<PermissionManager>();

  int _currentPage = 0;
  VanishPermissionStatus _notifStatus = VanishPermissionStatus.denied;
  VanishPermissionStatus _micStatus = VanishPermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkInitialStatuses();
  }

  Future<void> _checkInitialStatuses() async {
    final notif = await _permissionManager.checkPermissionStatus(VanishPermissionType.notification);
    final mic = await _permissionManager.checkPermissionStatus(VanishPermissionType.microphone);
    if (mounted) {
      setState(() {
        _notifStatus = notif;
        _micStatus = mic;
      });
    }
  }

  Future<void> _requestNotification() async {
    HapticFeedback.lightImpact();
    final status = await _permissionManager.requestPermission(VanishPermissionType.notification);
    setState(() {
      _notifStatus = status;
    });

    if (status == VanishPermissionStatus.granted) {
      showSuccessToast(message: 'Notification permission granted!');
      _nextPage();
    } else if (status == VanishPermissionStatus.permanentlyDenied) {
      showErrorToast(message: 'Permission permanently denied. Please enable it in system settings.');
    } else {
      showWarningToast(message: 'Permission denied. Please allow notifications to receive call alerts.');
    }
  }

  Future<void> _requestMicrophone() async {
    HapticFeedback.lightImpact();
    final status = await _permissionManager.requestPermission(VanishPermissionType.microphone);
    setState(() {
      _micStatus = status;
    });

    if (status == VanishPermissionStatus.granted) {
      showSuccessToast(message: 'Microphone permission granted!');
      _nextPage();
    } else if (status == VanishPermissionStatus.permanentlyDenied) {
      showErrorToast(message: 'Permission permanently denied. Please enable it in system settings.');
    } else {
      showWarningToast(message: 'Permission denied. Microphone is required to place or receive voice calls.');
    }
  }

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  Future<void> _finishOnboarding() async {
    HapticFeedback.mediumImpact();
    await _permissionManager.completeOnboarding();
    if (mounted) {
      context.go(AppRoutes.chats);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1024) {
              return _buildDesktopLayout(context);
            } else if (constraints.maxWidth > 600) {
              return _buildTabletLayout(context);
            } else {
              return _buildMobileLayout(context);
            }
          },
        ),
      ),
    );
  }

  // --- MOBILE LAYOUT (<600dp) ---
  Widget _buildMobileLayout(BuildContext context) {
    final colors = context.appColors;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                IconButton(
                  icon: Icon(CupertinoIcons.back, color: colors.textPrimary),
                  onPressed: _previousPage,
                )
              else
                const SizedBox(width: 48, height: 48),
              _buildProgressDots(),
              const SizedBox(width: 48, height: 48),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _buildCurrentStepContent(context, compact: true),
          ),
        ),
      ],
    );
  }

  // --- TABLET LAYOUT (600dp - 1024dp) ---
  Widget _buildTabletLayout(BuildContext context) {
    final colors = context.appColors;
    return Row(
      children: [
        // Left Panel (Illustration & Branding)
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: context.appGradients.purpleRose,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'VanishLink',
                  style: context.appTypography.titleLarge.copyWith(
                    color: colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 36,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                _buildLeftIllustration(),
              ],
            ),
          ),
        ),
        // Right Panel (Onboarding Wizard Content)
        Expanded(
          flex: 3,
          child: Container(
            color: colors.background,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        TextButton.icon(
                          onPressed: _previousPage,
                          icon: Icon(CupertinoIcons.back, color: colors.textPrimary, size: 16),
                          label: Text('Back', style: TextStyle(color: colors.textPrimary)),
                        )
                      else
                        const SizedBox(),
                      _buildProgressDots(),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: _buildCurrentStepContent(context, compact: false),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- DESKTOP/WEB LAYOUT (>1024dp) ---
  Widget _buildDesktopLayout(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Row(
      children: [
        // Left Sidebar: Step Indicators
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: colors.card,
            border: Border(
              right: BorderSide(
                color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
              ),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VanishLink',
                style: typography.titleMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 48),
              _buildSidebarStep(0, 'Welcome', CupertinoIcons.shield),
              _buildSidebarStep(1, 'Notifications', CupertinoIcons.bell),
              _buildSidebarStep(2, 'Microphone', CupertinoIcons.mic),
              _buildSidebarStep(3, 'Setup Complete', CupertinoIcons.checkmark_seal),
              const Spacer(),
              Text(
                'v1.0.0 Beta',
                style: typography.labelSmall.copyWith(color: colors.textTertiary),
              ),
            ],
          ),
        ),
        // Main Content Area
        Expanded(
          child: Container(
            color: colors.background,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Card(
                  elevation: 8,
                  shadowColor: colors.black.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: colors.border.withValues(alpha: context.isDark ? 0.2 : 0.4),
                    ),
                  ),
                  color: colors.card,
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_currentPage > 0)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              onPressed: _previousPage,
                              icon: Icon(CupertinoIcons.back, size: 16, color: colors.textPrimary),
                              label: Text('Back', style: TextStyle(color: colors.textPrimary)),
                            ),
                          ),
                        const SizedBox(height: 16),
                        _buildCurrentStepContent(context, compact: false),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- REUSABLE BUILD BLOCKS ---
  Widget _buildProgressDots() {
    final colors = context.appColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        final active = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? colors.primary : colors.textTertiary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildSidebarStep(int stepIndex, String title, IconData icon) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final isActive = _currentPage == stepIndex;
    final isCompleted = _currentPage > stepIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? colors.primary.withValues(alpha: 0.1)
                  : (isCompleted ? colors.success.withValues(alpha: 0.1) : Colors.transparent),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? colors.primary
                    : (isCompleted ? colors.success : colors.textTertiary.withValues(alpha: 0.3)),
                width: 2,
              ),
            ),
            child: Icon(
              isCompleted ? CupertinoIcons.checkmark : icon,
              size: 16,
              color: isActive
                  ? colors.primary
                  : (isCompleted ? colors.success : colors.textTertiary),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: typography.bodyMedium.copyWith(
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive
                  ? colors.textPrimary
                  : (isCompleted ? colors.textSecondary : colors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftIllustration() {
    final colors = context.appColors;
    IconData icon;
    switch (_currentPage) {
      case 0:
        icon = CupertinoIcons.shield_fill;
        break;
      case 1:
        icon = CupertinoIcons.bell_fill;
        break;
      case 2:
        icon = CupertinoIcons.mic_fill;
        break;
      default:
        icon = CupertinoIcons.checkmark_seal_fill;
    }

    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 96,
        color: colors.white,
      ),
    );
  }

  Widget _buildCurrentStepContent(BuildContext context, {required bool compact}) {
    switch (_currentPage) {
      case 0:
        return _buildStepWelcome(compact);
      case 1:
        return _buildStepNotification(compact);
      case 2:
        return _buildStepMicrophone(compact);
      default:
        return _buildStepComplete(compact);
    }
  }

  Widget _buildStepWelcome(bool compact) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Column(
      children: [
        if (compact) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(CupertinoIcons.shield_fill, size: 64, color: colors.primary),
          ),
        ],
        const SizedBox(height: 32),
        Text(
          'Secure Ephemeral Calling',
          style: typography.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: compact ? 24 : 28,
            color: colors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'VanishLink routes encrypted calls directly between peer devices. We need to request permissions to deliver incoming notifications and initialize microphone streams.',
          style: typography.bodyMedium.copyWith(color: colors.textSecondary, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildBenefitItem('End-to-End Encryption', 'Your voice is fully encrypted and direct.', CupertinoIcons.lock_shield),
        const SizedBox(height: 12),
        _buildBenefitItem('No Logs Preserved', 'Call sessions are fully ephemeral and deleted automatically.', CupertinoIcons.delete_simple),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: _nextPage,
            child: const Text('Get Started'),
          ),
        ),
      ],
    );
  }

  Widget _buildStepNotification(bool compact) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final isGranted = _notifStatus == VanishPermissionStatus.granted;
    final isPermanent = _notifStatus == VanishPermissionStatus.permanentlyDenied;

    return Column(
      children: [
        if (compact) ...[
          const SizedBox(height: 24),
          Icon(
            CupertinoIcons.bell_fill,
            size: 64,
            color: isGranted ? colors.success : colors.primary,
          ),
        ],
        const SizedBox(height: 32),
        Text(
          'Incoming Call Alerts',
          style: typography.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: compact ? 24 : 28,
            color: colors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'We need notification permission to alert you and display incoming call screens when the app is running in the background or closed.',
          style: typography.bodyMedium.copyWith(color: colors.textSecondary, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildBenefitItem('Real-time Ringing Alerts', 'Get instantly notified when peers call you.', CupertinoIcons.phone_fill),
        const SizedBox(height: 12),
        _buildBenefitItem('Missed Call Notifications', 'Log missed call alerts even when closed.', CupertinoIcons.phone_badge_plus),
        const SizedBox(height: 48),
        if (isPermanent) ...[
          Text(
            'Notifications are permanently disabled. Open settings to turn on notifications manually.',
            style: typography.bodySmall.copyWith(color: colors.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isGranted ? colors.success : colors.primary,
              foregroundColor: colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: isPermanent
                ? _permissionManager.openSettings
                : (isGranted ? _nextPage : _requestNotification),
            child: Text(isPermanent
                ? 'Open System Settings'
                : (isGranted ? 'Continue' : 'Grant Notification Permission')),
          ),
        ),
        if (!isGranted && !isPermanent) ...[
          const SizedBox(height: 12),
          TextButton(
            onPressed: _nextPage,
            child: Text('Skip for now', style: typography.bodyMedium.copyWith(color: colors.textTertiary)),
          ),
        ],
      ],
    );
  }

  Widget _buildStepMicrophone(bool compact) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final isGranted = _micStatus == VanishPermissionStatus.granted;
    final isPermanent = _micStatus == VanishPermissionStatus.permanentlyDenied;

    return Column(
      children: [
        if (compact) ...[
          const SizedBox(height: 24),
          Icon(
            CupertinoIcons.mic_fill,
            size: 64,
            color: isGranted ? colors.success : colors.primary,
          ),
        ],
        const SizedBox(height: 32),
        Text(
          'Microphone Access',
          style: typography.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: compact ? 24 : 28,
            color: colors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Microphone permission is essential to capture and stream voice audio during voice and video calls.',
          style: typography.bodyMedium.copyWith(color: colors.textSecondary, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildBenefitItem('Direct Audio Streaming', 'Transmit high-fidelity real-time voice.', CupertinoIcons.waveform),
        const SizedBox(height: 12),
        _buildBenefitItem('Strict On-Call Policy', 'Audio is only recorded while actively calling.', CupertinoIcons.bolt_horizontal_circle_fill),
        const SizedBox(height: 48),
        if (isPermanent) ...[
          Text(
            'Microphone is permanently disabled. Open settings to grant microphone permission manually.',
            style: typography.bodySmall.copyWith(color: colors.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isGranted ? colors.success : colors.primary,
              foregroundColor: colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: isPermanent
                ? _permissionManager.openSettings
                : (isGranted ? _nextPage : _requestMicrophone),
            child: Text(isPermanent
                ? 'Open System Settings'
                : (isGranted ? 'Continue' : 'Grant Microphone Permission')),
          ),
        ),
        if (!isGranted && !isPermanent) ...[
          const SizedBox(height: 12),
          TextButton(
            onPressed: _nextPage,
            child: Text('Skip for now', style: typography.bodyMedium.copyWith(color: colors.textTertiary)),
          ),
        ],
      ],
    );
  }

  Widget _buildStepComplete(bool compact) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Column(
      children: [
        if (compact) ...[
          const SizedBox(height: 24),
          Icon(CupertinoIcons.checkmark_seal_fill, size: 64, color: colors.success),
        ],
        const SizedBox(height: 32),
        Text(
          'Onboarding Complete!',
          style: typography.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: compact ? 24 : 28,
            color: colors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Your security keys and device permissions are successfully registered. You can now place and receive end-to-end encrypted calls.',
          style: typography.bodyMedium.copyWith(color: colors.textSecondary, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: _finishOnboarding,
            child: const Text('Enter VanishLink'),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String title, String subtitle, IconData icon) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: typography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: typography.bodySmall.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
