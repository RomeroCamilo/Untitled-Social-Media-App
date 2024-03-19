// ignore_for_file: non_constant_identifier_names
import '../database/database_services.dart';
import '../database/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kDebugMode; // Import kDebugMode from foundation.dart

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});
  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  String private_profile = '0'; // Declare private_profile variable to track switch state

  @override
  Widget build(BuildContext context) {
    return Switch(
      value:
          private_profile == '1', // Convert private_profile to boolean for Switch widget
      activeColor: const Color.fromARGB(255, 120, 2, 2),
      onChanged: (bool value) {
        setState(() {
          private_profile =
              value ? '1' : '0'; // Update private_profile with the new switch state
        });

        if (kDebugMode) {
          // Use a logging framework (e.g., logger package) instead of print for production code
          debugPrint('Switch value changed: $private_profile, this is a string');
        }
      },
    );
  }
}

class EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();
  /* parameters for the cloud function */
  String username = '';
  String display_name = '';
  String biography = '';
  String private_profile = '1';
  String favoriteArtist1 = '';
  String favoriteArtist2 = '';
  String favoriteArtist3 = '';
  String favoriteGenre1 = '';
  String favoriteGenre2 = '';
  String favoriteGenre3 = '';
  String favoriteSong1 = '';
  String favoriteSong2 = '';
  String favoriteSong3 = '';

  late String user_id;
  User_Info? user_info; // This will store the fetched user data

  /* init with getting our current user_id */
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Retrieve the signed-in user's userId
  void _getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        user_id = user.uid;
        _fetchUser();
      });
    }
  }

  // Fetch user info for the current user
  void _fetchUser() async {
    try {
      User_Info userData = await DatabaseServices.getUserCloud(user_id);
      setState(() {
        user_info = userData; // Store the fetched data in user_info object.
        username = user_info?.display_name ?? "failed";
        biography = user_info?.biography ?? "failed";
        private_profile = user_info?.private_profile ?? "failed";

      });
    } catch (e) {
      print('Failed to fetch user info: $e');
      setState(() {
        //name = "could not fetch."; // Ensure setState is called to update the UI
      });
    }
  }

  




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
        ),
        body: SingleChildScrollView(
          // This is the background container/box that hides behind the profile picture
          child: Stack(children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              height: 150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Color.fromARGB(255, 38, 38, 38),
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            //This helps off center the profile picture to both be partially in the box & out of it
            const Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 48.0,
                      backgroundImage: NetworkImage(
                          'https://cdn.discordapp.com/attachments/1200217805258231910/1217713074220564492/LP_JASON.jpg?ex=660506ac&is=65f291ac&hm=84efeb4cf21f8feca3c1d3e3d34e167662a04fdce4a24fd0b2831e7f76917fdf&'),
                    ),
                  ),
                )),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),

                // Button To Update A User's Profile Picture
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 40),
                      backgroundColor: const Color.fromARGB(255, 205, 231, 237),
                    ),
                    // Add Cloud Function To Edit/Store User Selected Picture/Image
                    onPressed: () {
                      null;
                    },
                    child: const Text('Upload Picture',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 50,
                ),

                // The Start Of All The User Fields To Be Changed If Different From What Was Previously In The Database
                // REMINDER TO ADD VALIDATORS IF NEEDED FOR OTHER FIELDS BESIDES USERNAME
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(7.5)),
                      color: Color.fromARGB(255, 38, 38, 38)),
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('USERNAME',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('username'),
                              decoration:  InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: user_info?.username ?? 'USERNAME',),
                                  //hintText: 'USERNAME'),
                              // NEED TO ADD CHECK TO SEE IF USERNAME IS UNIQUE
                              validator: (value) {
                                if (value!.isEmpty || value.contains(' ')) {
                                  username = user_info?.display_name ?? "failed";
                                  return 'Please Enter Username Without Spaces';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                username = value!;
                              },
                            ),
                            const Text('DISPLAY NAME',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('display_name'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: user_info?.display_name ?? 'DISPLAY NAME',),
                                  //hintText: 'DISPLAY NAME'),
                              onSaved: (value) {
                                display_name = value!;
                              },
                            ),
                            const Text('BIO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('biography'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: user_info?.biography ?? 'BIOGRAPHY',),
                                  //hintText: 'BIO'),
                              onSaved: (value) {
                                biography = value!;
                              },
                            ),
                            const Text('FAVORITE ARTIST #1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoriteartist1'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE ARTIST #1'),
                              onSaved: (value) {
                                favoriteArtist1 = value!;
                              },
                            ),
                            const Text('FAVORITE ARTIST #2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoriteartist2'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE ARTIST #2'),
                              onSaved: (value) {
                                favoriteArtist2 = value!;
                              },
                            ),
                            const Text('FAVORITE ARTIST #3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoriteartist3'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE ARTIST #3'),
                              onSaved: (value) {
                                favoriteArtist3 = value!;
                              },
                            ),
                            const Text('FAVORITE GENRE #1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritegenre1'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE GENRE #1'),
                              onSaved: (value) {
                                favoriteGenre1 = value!;
                              },
                            ),
                            const Text('FAVORITE GENRE #2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritegenre2'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE GENRE #2'),
                              onSaved: (value) {
                                favoriteGenre2 = value!;
                              },
                            ),
                            const Text('FAVORITE GENRE #3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritegenre3'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE GENRE #3'),
                              onSaved: (value) {
                                favoriteGenre3 = value!;
                              },
                            ),
                            const Text('FAVORITE SONG #1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritesong1'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE SONG #1'),
                              onSaved: (value) {
                                favoriteSong1 = value!;
                              },
                            ),
                            const Text('FAVORITE SONG #2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritesong2'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE SONG #2'),
                              onSaved: (value) {
                                favoriteSong2 = value!;
                              },
                            ),
                            const Text('FAVORITE SONG #3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritesong3'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'FAVORITE SONG #3'),
                              onSaved: (value) {
                                favoriteSong3 = value!;
                              },
                            ),
                            const Text('PUBLIC OR PRIVATE',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SwitchExample(),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(400, 40),
                                  backgroundColor:
                                      const Color.fromARGB(255, 205, 231, 237),
                                ),
                                /* when button is clicked on to edit profile */
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    // add cloud function to update user info
                                    DatabaseServices.editUserCloud(user_id, username, display_name, biography, private_profile);
                                  }
                                },
                                child: const Text('UPDATE INFORMATION',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
