import 'package:flutter/material.dart';
import 'package:social_app/pages/home_page.dart';
import 'package:social_app/pages/notification_page.dart';
import 'package:social_app/pages/search_page.dart';
import 'package:social_app/pages/new_post_page.dart';
import '../pages/profile_page.dart';
import 'nav_bar.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPage();
}

class _NavBarPage extends State<NavBarPage> {
  int currentPageIndex = 0;
  final screens = [
    const HomePage(),
    const SearchPage(),
    const NewPostPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPageIndex],
      bottomNavigationBar: NavBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
