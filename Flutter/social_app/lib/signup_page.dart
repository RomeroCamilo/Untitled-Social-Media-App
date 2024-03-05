import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'authfunctions.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String displayName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        centerTitle: true,
        title: const Text(
          'APP NAME',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        ),
        // LOGOUT BUTTON TO REMOVE ONCE THE APP IS FINISHED (REPLACED WITH A LOGOUT BUTTON IN THE ACCOUNTS PAGE)
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut(); // Google Sign Out
                FirebaseAuth.instance.signOut(); // Email/PW Sign Out
                ScaffoldMessenger.of(
                        context) // snackbar notification to let the user know they're signed out
                    .showSnackBar(const SnackBar(content: Text('Logged Out')));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            const Column(
              children: [
                Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                )
              ],
            ),
            Container(
              decoration: const BoxDecoration(
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
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          key: const ValueKey('email'),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'EMAIL'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please Enter A Valid Email';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          key: const ValueKey('username'),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
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
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          key: const ValueKey('displayname'),
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'DISPLAY NAME'),
                          onSaved: (value) {
                            displayName = value!;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          key: const ValueKey('password'),
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'PASSWORD'),
                          validator: (value) {
                            if (value!.length < 6) {
                              return "Password Must Be > Than 6 Characters";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            password = value!;
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
                                /* signing the user up with the provided details. */
                                // changed this snippet to be in the if statement March 3rd
                                AuthServices.signupUser(email, username,
                                    displayName, password, context);
                              }
                            },
                            child: const Text('SIGN UP')),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(children: [
              SignInButton(
                Buttons.googleDark,
                onPressed: () async => {
                  await AuthServices().signInGoogle(
                      context), //added an await here so that the redirect doesn't happen b4 the user is signed in
                },
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text:
                          'Already Have An Account?\nTap Here To Go To The Login Page',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => goToLogin(context)),
                )
              ],
            ),
          ])),
    );
  }
}
