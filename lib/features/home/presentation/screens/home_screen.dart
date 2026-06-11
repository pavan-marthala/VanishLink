import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/features/home/presentation/screens/widgets/app_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true, body: buildBody(context));
  }

  Stack buildBody(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        navigationShell,
        Positioned(
          bottom: 0,
          child: AppNavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onTabSelected: (index) {
              navigationShell.goBranch(index);
            },
          ),
        ),
      ],
    );
  }
}
