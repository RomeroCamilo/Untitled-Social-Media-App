import 'package:firebase_auth/firebase_auth.dart';
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
  int currentPageIndex = 4; // Starting with the Profile page
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final screens = [
    const HomePage(),
    SearchPage(),
    const NewPostPage(),
    const NotificationPage(),
    ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid),
  ];

  void updatePageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => screens[currentPageIndex],
          );
        },
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          // Navigate to the screen associated with the NavBar
          navigatorKey.currentState?.popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}