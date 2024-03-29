import 'package:flutter/material.dart';
import 'package:social_app/navbar/body_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('This is the 2nd page')),
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
            child: const Text('Go to profile!'),
          ),
        ),
      ),
    );
  }
}
