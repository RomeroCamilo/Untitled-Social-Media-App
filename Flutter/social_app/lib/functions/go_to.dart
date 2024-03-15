import 'package:flutter/material.dart';
import 'package:social_app/firebase/signup_page.dart';
import 'package:social_app/main.dart';
import 'package:social_app/navbar/body_view.dart';
import 'package:social_app/pages/edit_profile_page.dart';
import 'package:social_app/pages/profile_page.dart';

void goToLogin(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}

void goToSignup(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignupPage()),
  );
}

void goToNavBarPage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const NavBarPage(),
    ),
  );
}

void goToProfile(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}

void goToEditProfile(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const EditProfilePage()),
  );
}
