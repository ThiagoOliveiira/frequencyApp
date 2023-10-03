import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  const DefaultBottomNavigationBar({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) => _handleNavigation(index),
      selectedIndex: currentPageIndex,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.book), label: 'Aulas'),
      ],
    );
  }

  _handleNavigation(int index) {
    if (index == 0) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/classroom');
    }
  }
}
