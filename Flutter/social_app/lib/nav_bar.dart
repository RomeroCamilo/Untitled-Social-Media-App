import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: const Color.fromARGB(255, 39, 38, 38),
      indicatorColor: const Color.fromARGB(255, 242, 238, 238),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
            selectedIcon: Icon(Icons.person_search),
            icon: Icon(Icons.person_search_outlined),
            label: "Search"),
        NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: "Post"),
        NavigationDestination(
          icon: Icon(Icons.notifications_sharp),
          selectedIcon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
            label: "Profile"),
      ],
    );
  }
}
