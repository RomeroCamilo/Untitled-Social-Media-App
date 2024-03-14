import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';
import 'profile_page.dart';
import 'database_services.dart';

// Website below is about the functions to access firebase authentication
// https://firebase.google.com/docs/auth/flutter/manage-users
void goToLogin(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}

void goToProfile(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}

class AuthServices {
  /* function where we sign in / signup through gmail */
  signInGoogle(context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error')));
    }
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Access the uid of the newly created user
    String uid = userCredential.user!.uid;

    // Access the email of the newly created user
    String gEmail = userCredential.user!.email!;

    String username = (userCredential.user!.displayName!).replaceAll(' ', '') +
        userCredential.user!.uid;

    String displayName = userCredential.user!.displayName!;

    String isPrivate = "0";

    // Step 3: Trigger Cloud Function to create user in the cloud
     //await DatabaseServices.addUserCloud(uid, gEmail, username, displayName, isPrivate);

    // finding a way to retrieve and connect the uid/email to mySQL
    // print(FirebaseAuth.instance.currentUser!.uid); <----- WORKS IN MAIN.DART/ETC.DART AS WELL AS HERE
    // WITH SAME FUNCTIONALITY, MIGHT BE THE WAY TO RETRIEVE THE UID FOR DATABASE!!!
    if (userCredential.user != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Log in Successful')));
      return userCredential;
    }
    return userCredential;
  }

  /* Non-google sign up / login service */
  static signupUser(String email, String username, String displayName,
      String password, BuildContext context) async {
    /* try to create user */
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Access the uid of the newly created user.
      String uid = userCredential.user!.uid;

      // Access the email of the newly created user.
      String fEmail = userCredential.user!.email!;

      /* account is initally public. 0 = public, 1 = private */
      String isPrivate = "0";

      // Step 3: Trigger Cloud Function to create user in the cloud
      await DatabaseServices.addUserCloud(uid, fEmail, username, displayName, isPrivate);

      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(
          email); // Changed this function from updateEmail due to depreciation

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
      goToLogin(context);
    }

    /* if error occurred when getting user */
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Provided Is Too Weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Provided Already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  static signinUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You Are Logged in')));
      goToProfile(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No User Found With This Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Does Not Match')));
      }
    }
  }
}
