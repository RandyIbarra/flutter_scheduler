// flutter
import 'package:flutter/material.dart';
// external packages
import 'package:firebase_auth/firebase_auth.dart';
// own library (private)
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/home/screen.dart';

/// Login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // firebase credentials, obtained after submit valid email and password
  UserCredential? creds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scheduler'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 5,
          horizontal: 8.0,
        ),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: .5,
            heightFactor: .8,
            // from own library
            child: LoginWidget(
              onLogin: (email, password) => FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password)
                  .then(
                    (value) => creds = value,
                  ),
              onSuccess: () {
                if (creds == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error in credentials. Please, try again.'),
                    ),
                  );
                } else if (creds!.user != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
