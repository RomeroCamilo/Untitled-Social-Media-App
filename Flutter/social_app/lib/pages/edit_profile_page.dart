// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:social_app/navbar/body_view.dart';
import 'package:social_app/pages/profile_page.dart';
import '../database/database_services.dart';
import '../database/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../database/tags.dart';
import 'package:flutter/foundation.dart'
    show kDebugMode; // Import kDebugMode from foundation.dart

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();
  /* parameters for the cloud function */
  String username = '';
  String display_name = '';
  String biography = '';
  String private_profile = '';
  static late String user_id;
  User_Info? user_info; // This will store the fetched user data

  /* will store updated information and pass into cloud functio */
  Tags myTags = Tags(
    user_id: '', // Set this to the actual user ID when available
    artist_tag_1: '',
    genre_tag_1: '',
    song_tag_1: '',
    artist_tag_2: '',
    genre_tag_2: '',
    song_tag_2: '',
    artist_tag_3: '',
    genre_tag_3: '',
    song_tag_3: '',
  );

  List<Tags> tag_info = []; // This will store the fetched user data

  /* init with getting our current user_id */
  @override
  void initState() {
    super.initState();
    /* store user_id after fetching from firebase */
    user_id = DatabaseServices.getUserId();
    setUp();
  }

  /* fetching all database values */
  void setUp() async {
    User_Info user_data = await DatabaseServices.getUserCloud(user_id);
    List<Tags> tagsData = await DatabaseServices.getUserTags(user_id);
    try {
      setState(() {
        /* store user_id after fetching from firebase */
        user_id = DatabaseServices.getUserId();

        /* init user fields */
        user_info = user_data;
        username = user_info?.username ?? "failed";
        display_name = user_info?.display_name ?? "failed";
        biography = user_info?.biography ?? "failed";
        private_profile = user_info?.private_profile ?? "failed";

        /* init tags */
        tag_info = tagsData;
        myTags.user_id = user_id;
      });
    } catch (e) {
      print('Failed to fetch user info: $e');
    }
  }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.media);
    if (result == null) {
      return;
    }
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'profile_picture/$user_id';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Uploaded: $urlDownload");

    setState(() {
      uploadTask = null;
    });
  }

  // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  //       stream: uploadTask?.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final data = snapshot.data!;
  //           double progress = data.bytesTransferred / data.totalBytes;

  //           return SizedBox(
  //             height: 50,
  //             child: Stack(
  //               fit: StackFit.expand,
  //               children: [
  //                 LinearProgressIndicator(
  //                   value: progress,
  //                   backgroundColor: Colors.grey,
  //                   color: Colors.green,
  //                 ),
  //                 Center(
  //                     child: Text(
  //                   '${(100 * progress).roundToDouble()}%',
  //                   style: const TextStyle(color: Colors.white),
  //                 ))
  //               ],
  //             ),
  //           );
  //         } else {
  //           return const SizedBox(height: 50);
  //         }
  //       },
  //     );

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
                      backgroundImage:
                          NetworkImage('${user_info?.profile_picture_path}'),
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
                      selectFile();
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
                              controller: TextEditingController(
                                  text: '${user_info?.username}'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              // NEED TO ADD CHECK TO SEE IF USERNAME IS UNIQUE
                              validator: (value) {
                                if (value!.isEmpty || value.contains(' ')) {
                                  username =
                                      user_info?.display_name ?? "failed";
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
                              controller: TextEditingController(
                                  text: '${user_info?.display_name}'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
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
                              controller: TextEditingController(
                                  text: '${user_info?.biography}'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
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
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].artist_tag_1
                                    : 'FAVORITE ARTIST #1',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteArtist1 = value!;
                                myTags.artist_tag_1 = value!;
                              },
                            ),
                            const Text('FAVORITE ARTIST #2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoriteartist2'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].artist_tag_2
                                    : 'FAVORITE ARTIST #2',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteArtist2 = value!;
                                myTags.artist_tag_2 = value!;
                              },
                            ),
                            const Text('FAVORITE ARTIST #3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoriteartist3'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].artist_tag_3
                                    : 'FAVORITE ARTIST #3',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteArtist3 = value!;
                                myTags.artist_tag_3 = value!;
                              },
                            ),
                            const Text('FAVORITE GENRE #1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritegenre1'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].genre_tag_1
                                    : 'FAVORITE GENRE #1',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteGenre1 = value!;
                                myTags.genre_tag_1 = value!;
                              },
                            ),
                            const Text('FAVORITE GENRE #2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritegenre2'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].genre_tag_2
                                    : 'FAVORITE GENRE #2',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteGenre2 = value!;
                                myTags.genre_tag_2 = value!;
                              },
                            ),
                            const Text('FAVORITE GENRE #3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritegenre3'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].genre_tag_3
                                    : 'FAVORITE GENRE #3',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteGenre3 = value!;
                                myTags.genre_tag_3 = value!;
                              },
                            ),
                            const Text('FAVORITE SONG #1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritesong1'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].song_tag_1
                                    : 'FAVORITE SONG #1',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteSong1 = value!;
                                myTags.song_tag_1 = value!;
                              },
                            ),
                            const Text('FAVORITE SONG #2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritesong2'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].song_tag_2
                                    : 'FAVORITE SONG #2',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteSong2 = value!;
                                myTags.song_tag_2 = value!;
                              },
                            ),
                            const Text('FAVORITE SONG #3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              key: const ValueKey('favoritesong3'),
                              controller: TextEditingController(
                                text: tag_info.isNotEmpty
                                    ? tag_info[0].song_tag_3
                                    : 'FAVORITE SONG #3',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                //favoriteSong3 = value!;
                                myTags.song_tag_3 = value!;
                              },
                            ),
                            const Text('PUBLIC OR PRIVATE',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            SwitchButton(
                              private_profile: private_profile,
                              onChanged: (String newValue) {
                                setState(() {
                                  private_profile = newValue;
                                });
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
                                /* when button is clicked on to edit profile */
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    // add cloud function to update user info
                                    DatabaseServices.editUserCloud(
                                        user_id,
                                        username,
                                        display_name,
                                        biography,
                                        private_profile);
                                    DatabaseServices.updateUserTags(
                                        user_id, myTags);
                                    uploadFile();
                                    // Navigator.pop(context);
                                  }
                                },
                                child: const Text('UPDATE INFORMATION',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            // buildProgress(),
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

class SwitchButton extends StatelessWidget {
  final String private_profile;
  final ValueChanged<String> onChanged;

  const SwitchButton({
    required this.private_profile,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: private_profile == '1', // Convert to boolean for Switch widget
      activeColor: const Color.fromARGB(255, 120, 2, 2),
      onChanged: (bool value) {
        onChanged(value ? '1' : '0'); // Convert boolean value to string
      },
    );
  }
}
