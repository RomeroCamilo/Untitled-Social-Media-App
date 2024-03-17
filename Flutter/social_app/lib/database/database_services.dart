import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_info.dart';
import 'relationship.dart';
import 'package:flutter/foundation.dart'
    show kDebugMode; // Import kDebugMode from foundation.dart

class DatabaseServices {
  //url to our cloud function instance.
  static const String baseUrl =
      'https://us-central1-music-social-media-app-414401.cloudfunctions.net';

  /* Function that will connect to our cloud function, and handle adding a new user without gmail sign in method. */
  static Future<void> addUserCloud(String userid, String email, String username,
      String displayName, String isPrivate, String biography, String profile_picture_path) async {
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
          'is_private': isPrivate
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
      String displayName, String biography, String isPrivate) async {
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
          'is_private': isPrivate
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
          is_private: userMap['is_private'] ?? false,
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
}
