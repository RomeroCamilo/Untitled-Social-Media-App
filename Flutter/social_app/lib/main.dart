import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'signup_page.dart';

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
          textTheme: GoogleFonts.bebasNeueTextTheme(),
          scaffoldBackgroundColor: const Color.fromARGB(255, 25, 25, 25)),
      home: const MyHomePage(title: 'Music Social Media App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void goToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        title: const Center(
            child: Text(
          'WELCOME',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: const Text(
                'APP NAME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: FittedBox(
                    child: FloatingActionButton.extended(
                        heroTag: 'Login Page Redirect',
                        backgroundColor:
                            const Color.fromARGB(255, 205, 231, 237),
                        label: const Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          goToLogin(context);
                        }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: FittedBox(
                    child: FloatingActionButton.extended(
                        heroTag: 'Sign Up Page Redirect',
                        backgroundColor:
                            const Color.fromARGB(255, 205, 231, 237),
                        label: const Text('SIGN UP'),
                        onPressed: () async {
                          goToSignup(context);
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
