import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_info.dart';
import 'relationship.dart';
import 'tags.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

// show kDebugMode; // Import kDebugMode from foundation.dart

class DatabaseServices {
  //url to our cloud function instance.
  static const String baseUrl =
      'https://us-central1-music-social-media-app-414401.cloudfunctions.net';

  /* Function that will connect to our cloud function, and handle adding a new user without gmail sign in method. */
  static Future<void> addUserCloud(
      String userid,
      String email,
      String username,
      String displayName,
      String isPrivate,
      String biography,
      String profile_picture_path) async {
    try {
      final response = await http.post(
        Uri.parse(
            /* cloud function link that handles adding login info to the database */
            '$baseUrl/userProfiles/helloHttp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        /* parameters to pass to the post request and then used to insert into database! */
        body: jsonEncode(<String, String>{
          'user_id': userid,
          'username': username,
          'display_name': displayName,
          'email': email,
          'profile_picture_path': profile_picture_path,
          'biography': biography,
          'private_profile': isPrivate
        }), // Convert the map to a JSON-encoded string
      );

      if (response.statusCode == 200) {
        print('Response from Cloud Function: ${response.body}');
      } else {
        print(
            'Failed to call Cloud Function. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling Cloud Function: $e');
    }
  }

  /* Function that will connect to our cloud function, and handle adding a editing a user. */
  static Future<void> editUserCloud(String userid, String username,
      String displayName, String biography, String private_profile) async {
    try {
      final response = await http.put(
        Uri.parse(
            /* cloud function link that handles adding login info to the database */
            '$baseUrl/userProfiles/helloHttp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        /* parameters to pass to the post request and then used to insert into database! */
        body: jsonEncode(<String, String>{
          'user_id': userid,
          'username': username,
          'display_name': displayName,
          'biography': biography,
          'private_profile': private_profile
        }), // Convert the map to a JSON-encoded string
      );

      if (response.statusCode == 200) {
        print('Response from Cloud Function: ${response.body}');
      } else {
        print(
            'Failed to call Cloud Function for put. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling Cloud Function for put: $e');
    }
  }

  /* cloud function to retrieve user data */
  static Future<User_Info> getUserCloud(String user_id) async {
    /* call our http endpoint */
    try {
      /* link with a unique user_id */
      final response = await http.get(
          Uri.parse('$baseUrl/userProfiles/helloHttp?user_id=$user_id'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print(
            'Response from Cloud Function this is the one?: ${response.body}');
        // Decode the JSON response into a User_Info object
        final Map<String, dynamic> userMap = json.decode(response.body);
        return User_Info(
          user_id: userMap['user_id'] ?? '',
          username: userMap['username'] ?? '',
          display_name: userMap['display_name'] ?? '',
          email: userMap['email'] ?? '',
          profile_picture_path: userMap['profile_picture_path'] ?? '',
          biography: userMap['biography'] ?? '',
          private_profile: userMap['private_profile'] ?? '',
        );
      } else {
        print('Failed to fetch user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch user');
      }
    } catch (error) {
      print('Error fetching user info: $error');
      rethrow;
    }
  }

  /* cloud function to search for a user. */
  static Future<User_Info> searchUserCloud(String username) async {


    /* call our http endpoint */
    try {
      /* link with a unique user_id */
      final response = await http.get(
          Uri.parse('$baseUrl/searchUser/helloHttp?username=$username'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {

        /* no data found for user scenario, return a */
        if (response.body.isEmpty) {
            print('No user found for username: $username');

            /* return a User_Info object with no data. */
            return User_Info(
            user_id: '',
            username: '',
            display_name: '',
            email: '',
            profile_picture_path: '',
            biography: '',
            private_profile: '',
          );
        }

        /* else we return the fetched data */
        print('Response from Cloud Function this is the one?: ${response.body}');
        // Decode the JSON response into a User_Info object
        final Map<String, dynamic> userMap = json.decode(response.body);
        return User_Info(
          user_id: userMap['user_id'] ?? '',
          username: userMap['username'] ?? '',
          display_name: userMap['display_name'] ?? '',
          email: userMap['email'] ?? '',
          profile_picture_path: userMap['profile_picture_path'] ?? '',
          biography: userMap['biography'] ?? '',
          private_profile: userMap['private_profile'] ?? '',
        );
      } 
      else {
        print('Failed to fetch user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch user');
      }
    } catch (error) {
      print('Error fetching user info: $error');
      rethrow;
    }
  }

  /* cloud function to retrieve user follower and following count */
  static Future<Relationship> getUserCount(String user_id) async {
    /* call our http endpoint */
    try {
      /* link with a unique user_id */
      final response = await http.get(
          Uri.parse('$baseUrl/userRelationship/helloHttp?user_id=$user_id'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print('Response from Cloud Function: ${response.body}');
        // Decode the JSON response into a User_Info object
        final Map<String, dynamic> userMap = json.decode(response.body);
        return Relationship(
          following_count: userMap['following_count'] ?? '',
          followed_count: userMap['followed_count'] ?? '',
          post_count: userMap['post_count'] ?? '',
        );
      } else {
        print('Failed to fetch user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch user');
      }
    } catch (error) {
      print('Error fetching user info: $error');
      rethrow;
    }
  }

  /* getting our user_tags */
  static Future<List<Tags>> getUserTags(String user_id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/favorites_tags/helloHttp?user_id=$user_id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Response from Cloud Function: ${response.body}');
        List<dynamic> tagsList = json.decode(response.body);
        return tagsList
            .map((tagData) => Tags(
                  user_id: tagData['user_id'] ?? '',
                  artist_tag_1: tagData['artist_tag_1'] ?? '',
                  genre_tag_1: tagData['genre_tag_1'] ?? '',
                  song_tag_1: tagData['song_tag_1'] ?? '',
                  artist_tag_2: tagData['artist_tag_2'] ?? '',
                  genre_tag_2: tagData['genre_tag_2'] ?? '',
                  song_tag_2: tagData['song_tag_2'] ?? '',
                  artist_tag_3: tagData['artist_tag_3'] ?? '',
                  genre_tag_3: tagData['genre_tag_3'] ?? '',
                  song_tag_3: tagData['song_tag_3'] ?? '',
                ))
            .toList();
      } else {
        print('Failed to fetch user tags. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch user tags');
      }
    } catch (error) {
      print('Error fetching user tags: $error');
      rethrow;
    }
  }

  /* put function to update the tags the user is displaying */
  static Future<void> updateUserTags(String user_id, Tags updatedTags) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/favorites_tags/helloHttp?user_id=$user_id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': updatedTags.user_id,
          'artist_tag_1': updatedTags.artist_tag_1,
          'genre_tag_1': updatedTags.genre_tag_1,
          'song_tag_1': updatedTags.song_tag_1,
          'artist_tag_2': updatedTags.artist_tag_2,
          'genre_tag_2': updatedTags.genre_tag_2,
          'song_tag_2': updatedTags.song_tag_2,
          'artist_tag_3': updatedTags.artist_tag_3,
          'genre_tag_3': updatedTags.genre_tag_3,
          'song_tag_3': updatedTags.song_tag_3,
        }),
      );

      if (response.statusCode == 200) {
        print('User tags updated successfully: ${response.body}');
      } else {
        print(
            'Failed to update user tags. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update user tags');
      }
    } catch (error) {
      print('Error updating user tags: $error');
      rethrow;
    }
  }

  static Future<void> createUserTags(String user_id, Tags newTags) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favorites_tags/helloHttp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode([
          {
            'user_id': user_id,
            'artist_tag_1': newTags.artist_tag_1,
            'genre_tag_1': newTags.genre_tag_1,
            'song_tag_1': newTags.song_tag_1,
            'artist_tag_2': newTags.artist_tag_2,
            'genre_tag_2': newTags.genre_tag_2,
            'song_tag_2': newTags.song_tag_2,
            'artist_tag_3': newTags.artist_tag_3,
            'genre_tag_3': newTags.genre_tag_3,
            'song_tag_3': newTags.song_tag_3,
          }
        ]),
      );

      if (response.statusCode == 200) {
        print('User tags created successfully: ${response.body}');
      } else {
        print(
            'Failed to create user tags. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create user tags');
      }
    } catch (error) {
      print('Error creating user tags: $error');
      rethrow;
    }
  }

  // Retrieve the signed-in user's userId from firebase.
  static String getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else
      return '';
  }

  // Fetch user info for the current user and return that user with its data such as username.
  static Future<User_Info> fetchUser(String user_id) async {
    try {
      User_Info userData = await DatabaseServices.getUserCloud(user_id);

      return userData;
    } catch (e) {
      print('Failed to fetch user info: $e');
      // Rethrow the exception to be handled by the caller
      throw Exception('Failed to fetch user info');
    }
  }
}
