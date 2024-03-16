import 'package:flutter/material.dart';
import 'package:social_app/navbar/body_view.dart';
import 'package:social_app/pages/profile_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('4th page')),
        backgroundColor: const Color.fromARGB(170, 0, 99, 224),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Abuelaaaa te amo')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NavBarPage()));
            },
            child: const Text('home'),
          ),
        ),
      ),
    );
  }
}
