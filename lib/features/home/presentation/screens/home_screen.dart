import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/features/home/presentation/screens/widgets/responsive_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavigation(navigationShell: navigationShell);
  }
}
