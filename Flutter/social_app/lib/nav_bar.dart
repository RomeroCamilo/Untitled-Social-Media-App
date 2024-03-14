// import 'package:flutter/material.dart';

// class CustomNavigationBar extends StatelessWidget {
//   final List<NavigationDestination> destinations;
//   final int selectedIndex;
//   final Color indicatorColor;
//   final ValueChanged<int> onDestinationSelected;

//   const CustomNavigationBar({
//     Key? key,
//     required this.destinations,
//     required this.selectedIndex,
//     required this.onDestinationSelected,
//     this.indicatorColor = Colors.blue,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: selectedIndex,
//       onTap: onDestinationSelected,
//       items: destinations.map((destination) {
//         return BottomNavigationBarItem(
//           icon: destination.icon,
//           label: destination.label,
//           activeIcon: destination.selectedIcon,
//         );
//       }).toList(),
//       selectedLabelStyle: TextStyle(color: indicatorColor),
//       selectedItemColor: indicatorColor,
//       unselectedItemColor: Colors.grey,
//     );
//   }
// }

// class NavigationDestination {
//   final Icon icon;
//   final Icon? selectedIcon;
//   final String label;

//   const NavigationDestination({
//     required this.icon,
//     this.selectedIcon,
//     required this.label,
//   });
// }
