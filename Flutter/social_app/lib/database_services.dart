import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'taskclass.dart';

class DatabaseServices{

  //url to our cloud function instance.
  static const String baseUrl = 'https://us-central1-music-social-media-app-414401.cloudfunctions.net';

  // Function to add a new task
  static Future<void> addUser(String email, String username, String displayName, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/User-Profile/tasksApi'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          //'Task_ID': task.taskId,
          //'Task_Name': task.taskName,
          //'Task_Info': task.taskInfo,
          //'Completed': task.completed,
          //'Unique_User_ID': task.uid,
        }),
      );
      print('Response: ${response.statusCode}');
      if (response.statusCode == 201) {
        // Use the correct status code
        print('Task added successfully');
      } else {
        print('Failed to add task. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add task');
      }
    } catch (error) {
      print('Error adding task: $error');
    }
  }
}
