import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();
  String username = '';
  String displayName = '';
  String bio = '';
  String favoriteArtist1 = '';
  String favoriteArtist2 = '';
  String favoriteArtist3 = '';
  String favoriteGenre1 = '';
  String favoriteGenre2 = '';
  String favoriteGenre3 = '';
  String favoriteSong1 = '';
  String favoriteSong2 = '';
  String favoriteSong3 = '';

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
            Align(
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
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'USERNAME'),
                              // NEED TO ADD CHECK TO SEE IF USERNAME IS UNIQUE

                              validator: (value) {
                                if (value!.isEmpty || value.contains(' ')) {
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
                              key: const ValueKey('displayname'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'DISPLAY NAME'),
                              onSaved: (value) {
                                displayName = value!;
                              },
                            ),
                            const Text('BIO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('bio'),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(color: Colors.white),
                                  // Replace hint text with old user information thats about to be changed
                                  hintText: 'BIO'),
                              onSaved: (value) {
                                bio = value!;
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
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(400, 40),
                                  backgroundColor:
                                      const Color.fromARGB(255, 205, 231, 237),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    // add cloud function to update user info
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
