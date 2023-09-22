import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:purva/bottomNav.dart';
import 'package:purva/firebase_options.dart';
import 'package:purva/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'purvan',
      home: FutureBuilder<User?>(
        future: _auth.authStateChanges().first, // Listen for changes in authentication state
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator while checking authentication state
          } else {
            final bool isLoggedIn = snapshot.hasData;

            return isLoggedIn ? const BottomNav() : const LoginScreen();
          }
        },
      ),
    );
  }
}


