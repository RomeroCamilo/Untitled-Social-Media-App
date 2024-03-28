import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/functions/go_to.dart';
import 'package:social_app/navbar/body_view.dart';
//import 'package:social_app/navbar/nav_bar.dart';
import '../database/database_services.dart';
import '../database/user_info.dart';
import '../database/relationship.dart';
import '../database/tags.dart';

class OtherProfilePage extends StatefulWidget {
  final String uid;
  const OtherProfilePage({super.key, required this.uid});
  @override
  OtherProfilePageState createState() => OtherProfilePageState();
}

class OtherProfilePageState extends State<OtherProfilePage> {
  User_Info? user_info; // This will store the fetched user data
  List<Tags> tag_info = []; // This will store the fetched user data
  Relationship?
      user_stats; // This will store the fetched user data statistics (posts, following, etc)
  String name = "";
  int currentPageIndex = 0;

  /* init with getting our current user_id */
  @override
  void initState() {
    super.initState();
    setUp();
  }

  /* fetching all database values for specific user id. */
  void setUp() async {
    User_Info user_data = await DatabaseServices.getUserCloud(widget.uid);
    List<Tags> tagsData = await DatabaseServices.getUserTags(widget.uid);
    Relationship userFollowerData =
        await DatabaseServices.getUserCount(widget.uid);

    try {
      setState(() {
        /* init user fields */
        user_info = user_data;
        /* init tags */
        tag_info = tagsData;
        /* fetch stats */
        user_stats = userFollowerData;
      });
    } catch (e) {
      print('Failed to fetch user info: $e');
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
                const CircleAvatar(
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
                    Text(
                      //"jason liang",
                      user_info?.display_name ?? name,
                      //user_data[0].display_name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30),
                    ),
                  ],
                ),

                // USERNAME SECTION
                Text(
                  user_info?.username ?? name,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),

                // POSTS, FOLLOWERS, FOLLOWING COUNT STATISTICS SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          user_stats?.followed_count.toString() ?? name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        const Text(
                          "FOLLOWERS",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          user_stats?.post_count.toString() ?? name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        const Text(
                          "POSTS",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          user_stats?.following_count.toString() ?? name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        const Text(
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
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ))
                  ],
                ),

                // FAVORITES SECTION
                Row(children: [
                  const Text(
                    "Artists ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 205, 231, 237),
                        fontSize: 24),
                  ),
                  Flexible(
                    child: Text(
                      tag_info.isNotEmpty
                          ? "${tag_info[0].artist_tag_1 ?? ''} | ${tag_info[0].artist_tag_2 ?? ''} | ${tag_info[0].artist_tag_3 ?? ''}"
                          : "",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ]),
                Row(children: [
                  const Text(
                    "Genres ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 205, 231, 237),
                        fontSize: 24),
                  ),
                  Flexible(
                    child: Text(
                      //"Metalcore : Alternative Metal : Hyperpop",
                      tag_info.isNotEmpty
                          ? "${tag_info[0].genre_tag_1 ?? ''} | ${tag_info[0].genre_tag_2 ?? ''} | ${tag_info[0].genre_tag_3 ?? ''}"
                          : "",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ]),
                Row(children: [
                  const Text(
                    "Songs ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 205, 231, 237),
                        fontSize: 24),
                  ),
                  Flexible(
                    child: Text(
                      //"My December",
                      tag_info.isNotEmpty
                          ? "${tag_info[0].song_tag_1 ?? ''} | ${tag_info[0].song_tag_2 ?? ''} | ${tag_info[0].song_tag_3 ?? ''}"
                          : "",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ]),

                // POSTS SECTION
                const Text(
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
