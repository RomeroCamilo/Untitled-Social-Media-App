import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      centerTitle: true,
      title: const Text(
        'EDIT PROFILE',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
      ),
    ));
  }
}
