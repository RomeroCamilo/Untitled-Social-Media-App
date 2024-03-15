import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/functions/go_to.dart';
import '../database/database_services.dart';
import '../database/user_info.dart';
import '../database/relationship.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  User_Info? user_info; // This will store the fetched user data
  Relationship? user_count; // This will store the fetched user data
  late String user_id;

  String name = "";

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
        _fetchCount();
      });
    }
  }

  // Fetch user info for the current user
  void _fetchUser() async {
    try {
      User_Info userData = await DatabaseServices.getUserCloud(user_id);
      setState(() {
        user_info = userData; // Store the fetched data in user_info
        //name = "called";
      });
    } catch (e) {
      print('Failed to fetch user info: $e');
      setState(() {
        //name = "could not fetch."; // Ensure setState is called to update the UI
      });
    }
  }

  // Fetch user follower count for the current user
  void _fetchCount() async {
    try {
      Relationship userFollowerData = await DatabaseServices.getUserCount(user_id);
      setState(() {
        user_count = userFollowerData; // Store the fetched data in user_info
        //name = "called";
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
                      //"jason liang",
                      user_info?.display_name ?? name,
                      //user_data[0].display_name,
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
                  user_info?.username ?? name,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),

                // POSTS, FOLLOWERS, FOLLOWING COUNT SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          //"134",
                          user_count?.followed_count.toString() ?? name,
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
                          //"3213",
                          user_count?.following_count.toString() ?? name,
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
                          user_info?.biography ?? name,
                      //"he/him\nNYC\n22",
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
