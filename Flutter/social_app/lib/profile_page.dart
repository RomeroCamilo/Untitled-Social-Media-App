import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/authfunctions.dart';
import 'package:social_app/edit_profile_page.dart';
import 'database_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  void goToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
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
          'PROFILE',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                // PROFILE PICTURE SECTION
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                        'https://cdn.discordapp.com/attachments/1200217805258231910/1217713074220564492/LP_JASON.jpg?ex=660506ac&is=65f291ac&hm=84efeb4cf21f8feca3c1d3e3d34e167662a04fdce4a24fd0b2831e7f76917fdf&'),
                  ),
                ),

                // DISPLAY NAME & EDIT PROFILE PAGE/SETTINGS OR FOLLOW BUTTON SECTION
                // TO DO: NEED TO ADD IF STATEMENT TO DETERMINE WHETHER TO SHOW EDIT OR FOLLOW BUTTON
                // RIGHT NOW THE SETTINGS ICON SIMPLY CALLS A LOGOUT FUNCTION, IN THE FUTURE IMPLEMENT A NEW DART PAGE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        goToEditProfile(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Jason Liang",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30),
                    ),
                    IconButton(
                      onPressed: () async {
                        await GoogleSignIn().signOut(); // Google Sign Out
                        FirebaseAuth.instance.signOut(); // Email/PW Sign Out
                        ScaffoldMessenger.of(
                                context) // snackbar notification to let the user know they're signed out
                            .showSnackBar(
                                const SnackBar(content: Text('Logged Out')));
                        goToLogin(context);
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                // USERNAME SECTION
                Text(
                  "@json_a9",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),

                // POSTS, FOLLOWERS, FOLLOWING COUNT SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "134",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "FOLLOWERS",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "14",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "POSTS",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "3213",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "FOLLOWING",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),

                // BIO SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      "he/him\nNYC\n22",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ))
                  ],
                ),

                // FAVORITES SECTION
                Row(children: [
                  Text(
                    "Artists ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 205, 231, 237),
                        fontSize: 24),
                  ),
                  Flexible(
                    child: Text(
                      "Linkin Park : Taylor Swift : Ice Nine Kills",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ]),
                Row(children: [
                  Text(
                    "Genres ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 205, 231, 237),
                        fontSize: 24),
                  ),
                  Flexible(
                    child: Text(
                      "Metalcore : Alternative Metal : Hyperpop",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ]),
                Row(children: [
                  Text(
                    "Songs ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 205, 231, 237),
                        fontSize: 24),
                  ),
                  Flexible(
                    child: Text(
                      "My December",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ]),

                // POSTS SECTION
                Text(
                  "POSTS",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
