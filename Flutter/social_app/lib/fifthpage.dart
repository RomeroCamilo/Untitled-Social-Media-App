import 'package:flutter/material.dart';

import 'package:social_app/profile_page.dart';

class FifthRoute extends StatelessWidget {
  const FifthRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            child: const Text('home'),
          ),
        ),
      ),
    );
  }
}
