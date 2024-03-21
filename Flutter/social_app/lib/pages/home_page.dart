import 'package:flutter/material.dart';
import 'package:social_app/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: const Text('homme'),
          ),
        ),
      ),
    );
  }
}
