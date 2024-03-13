import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseServices{

  //url to our cloud function instance.
  static const String baseUrl = 'https://us-central1-music-social-media-app-414401.cloudfunctions.net';

  /* Function that will connect to our cloud function, and handle adding a new user without gmail sign in method. */
  static Future<void> addUserCloud(String userid, String email, String username, String displayName, String isPrivate) async {
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
          'is_private': isPrivate
        }), // Convert the map to a JSON-encoded string
      );

      if (response.statusCode == 200) {
        print('Response from Cloud Function: ${response.body}');
      } else {
        print('Failed to call Cloud Function. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling Cloud Function: $e');
    }
  }

  /* cloud function to retrieve user data */
  /* 
    sample usage:
    var user_id = '123abc';
    var result = await getUserCloud(String user_id);
    var username = result['username'];
  */
  static Future<void> getUserCloud(String user_id) async {

    try {
      /* link with a unique user_id */
      var uri = Uri.http(baseUrl, '/userProfiles/helloHttp', {'user_id': user_id});
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      /* return the values */
      if (response.statusCode == 200) {
        print('Response from Cloud Function: ${response.body}');
        // Decode the JSON response and return it
        return json.decode(response.body);
      } 
      else{
        print('Failed to call Cloud Function. Status code: ${response.statusCode}');
      }
    } 
    catch (e){
      print('Error calling Cloud Function: $e');
    }
}

    
  
  




}
