import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  const DefaultBottomNavigationBar({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: NavigationBar(
        height: 65,
        onDestinationSelected: (int index) => _handleNavigation(index),
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.blueGrey[100],
        surfaceTintColor: Colors.white,
        indicatorColor: Colors.white,
        elevation: 5,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Aulas'),
        ],
      ),
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
