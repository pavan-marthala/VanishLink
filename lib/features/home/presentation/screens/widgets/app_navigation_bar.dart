import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vanish_link/core/theme/app_colors.dart';
import 'package:vanish_link/core/theme/app_theme.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final Function(int index) onTabSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    final items = [
      NavigationItem(
        title: 'Chats',
        icon: Icon(
          CupertinoIcons.chat_bubble_2,
          color: colors.textPrimary,
          size: 24,
        ),
      ),
      NavigationItem(
        title: 'Request',
        icon: Icon(Icons.inbox, color: colors.textPrimary, size: 24),
      ),
      NavigationItem(
        title: 'Profile',
        icon: Icon(CupertinoIcons.person, color: colors.textPrimary, size: 24),
      ),
      // NavigationItem(
      //   title: 'Search',
      //   icon: Icon(CupertinoIcons.search, color: colors.textPrimary, size: 24),
      // ),
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? screenWidth : 450),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            return SafeArea(
              top: false,
              child: Row(
                children: [
                  NavBar(
                    colors: colors,
                    items: items,
                    selectedIndex: selectedIndex,
                    onTabSelected: onTabSelected,
                    size: size,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 24,
                      left: 8,
                      bottom: 8,
                      top: 8,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors.textPrimary.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: colors.background.withValues(alpha: 0.75),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.textPrimary.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.search,
                            color: colors.textPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.colors,
    required this.items,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.size,
  });

  final AppColors colors;
  final List<NavigationItem> items;
  final int selectedIndex;
  final Function(int index) onTabSelected;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 8, bottom: 8, top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: colors.textPrimary.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: colors.background.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: colors.textPrimary.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = index == selectedIndex;
                  return Expanded(
                    child: NavBarItem(
                      onTabSelected: () {
                        onTabSelected(index);
                      },
                      size: size,
                      isSelected: isSelected,
                      colors: colors,
                      item: item,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.onTabSelected,
    required this.size,
    required this.isSelected,
    required this.colors,
    required this.item,
  });

  final VoidCallback onTabSelected;
  final Size size;
  final bool isSelected;
  final AppColors colors;
  final NavigationItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabSelected,
      child: Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? colors.white : colors.textPrimary,
                BlendMode.srcIn,
              ),
              child: item.icon,
            ),
            Expanded(
              child: Text(
                item.title,
                style: context.theme.appTypography.labelSmall.copyWith(
                  color: isSelected ? colors.white : colors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  String title;
  Widget icon;

  NavigationItem({required this.title, required this.icon});
}
