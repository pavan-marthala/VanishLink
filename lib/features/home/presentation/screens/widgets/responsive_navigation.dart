import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/features/chat/domain/services/unread_service.dart';
import 'package:vanish_link/features/home/presentation/screens/widgets/app_navigation_bar.dart';

class ResponsiveNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ResponsiveNavigation({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: getIt<UnreadService>().globalUnreadCount,
      builder: (context, snapshot) {
        final unreadCount = snapshot.data ?? 0;

        if (context.isDesktop) {
          return Scaffold(
            backgroundColor: context.theme.appColors.background,
            body: Row(
              children: [
                _DesktopSidebar(
                  selectedIndex: navigationShell.currentIndex,
                  unreadCount: unreadCount,
                  onTabSelected: (index) {
                    navigationShell.goBranch(index);
                  },
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: context.theme.appColors.border.withValues(alpha: 0.5),
                ),
                Expanded(child: navigationShell),
              ],
            ),
          );
        } else {
          // Mobile & Tablet: Glassmorphic Bottom Navigation
          return Scaffold(
            backgroundColor: context.theme.appColors.background,
            extendBodyBehindAppBar: true,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                navigationShell,
                Positioned(
                  bottom: 0,
                  child: AppNavigationBar(
                    selectedIndex: navigationShell.currentIndex,
                    unreadCount: unreadCount,
                    onTabSelected: (index) {
                      navigationShell.goBranch(index);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  final int selectedIndex;
  final int unreadCount;
  final Function(int index) onTabSelected;

  const _DesktopSidebar({
    required this.selectedIndex,
    required this.unreadCount,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    final navItems = [
      _SidebarItemData(
        title: 'Chats',
        icon: CupertinoIcons.chat_bubble_2,
        activeIcon: CupertinoIcons.chat_bubble_2_fill,
      ),
      _SidebarItemData(
        title: 'Requests',
        icon: Icons.inbox_outlined,
        activeIcon: Icons.inbox,
      ),
      _SidebarItemData(
        title: 'Profile',
        icon: CupertinoIcons.person,
        activeIcon: CupertinoIcons.person_fill,
      ),
    ];

    return Container(
      width: 80,
      height: double.infinity,
      color: colors.card,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              // Premium Logo / Icon wrapper
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: context.appGradients.purpleRose,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.flash_on_rounded, // Premium vanish lightning icon
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Navigation Items
              Expanded(
                child: Column(
                  children: List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    final isSelected = index == selectedIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _SidebarItem(
                        icon: isSelected ? item.activeIcon : item.icon,
                        title: item.title,
                        isSelected: isSelected,
                        badgeCount: index == 0 ? unreadCount : 0,
                        onTap: () => onTabSelected(index),
                      ),
                    );
                  }),
                ),
              ),
              // Search/Discover Button at the bottom
              _SidebarItem(
                icon: CupertinoIcons.search,
                title: 'Search',
                isSelected: false,
                onTap: () {
                  context.push(AppRoutes.discover);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarItemData {
  final String title;
  final IconData icon;
  final IconData activeIcon;

  const _SidebarItemData({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    this.badgeCount = 0,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    final typography = context.theme.appTypography;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Active bar indicator on the left side
                  if (widget.isSelected)
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  // Animated container background bubble on hover / active selection
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.isSelected
                          ? colors.primary
                          : _isHovered
                          ? colors.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.isSelected
                          ? Colors.white
                          : _isHovered
                          ? colors.primary
                          : colors.textPrimary,
                      size: 24,
                    ),
                  ),
                  if (widget.badgeCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.error,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.badgeCount > 99 ? '99+' : '${widget.badgeCount}',
                          style: typography.bodySmall.copyWith(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.title,
                style: typography.labelSmall.copyWith(
                  color: widget.isSelected
                      ? colors.primary
                      : colors.textSecondary,
                  fontSize: 10.5,
                  fontWeight: widget.isSelected
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
