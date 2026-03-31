import 'package:fintech_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: themeExt.primary,
        unselectedItemColor: themeExt.textPrimary,
        onTap: (value) => navigationShell.goBranch(value, initialLocation: value == navigationShell.currentIndex),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
