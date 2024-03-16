import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:social_app/functions/go_to.dart';
import 'firebase/firebase_options.dart';
import 'firebase/authfunctions.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Social Media App',
      theme: ThemeData(
          textTheme: GoogleFonts.josefinSansTextTheme(),
          scaffoldBackgroundColor: const Color.fromARGB(255, 25, 25, 25)),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String email = '';
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
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
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
                  'LOGIN',
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
                            hintText: 'EMAIL',
                          ),
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
                          key: const ValueKey('password'),
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'PASSWORD'),
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 205, 231, 237),
                                minimumSize: const Size(400, 40)),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                AuthServices.signinUser(
                                    email, password, context);
                              }
                            },
                            child: const Text('LOGIN',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
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
                  // const HomePage(),
                  goToNavBarPage(context)
                },
              ),
            ]),
            Column(
              children: [
                RichText(
                    text: TextSpan(
                        text:
                            "Don't Have An Account?\nTap Here To Go To The Signup Page",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => goToSignup(context)))
              ],
            )
          ])),
    );
  }
}
