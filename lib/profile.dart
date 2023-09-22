import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purva/login_screen.dart';

class Profile extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Text("Profile Screen"),
        Center(
          child: ElevatedButton(
            onPressed: () async {
          // Sign out the user
          await _auth.signOut();
        
          // Navigate back to the NumberScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
            },
            child: Text("Sign Out"),
          ),
        ),
      ],
    );
  }
}
