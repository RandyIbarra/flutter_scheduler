// flutter
import 'package:flutter/material.dart';
// firebase
import 'package:firebase_auth/firebase_auth.dart';
// this project
import 'package:flutter_scheduler/home/screen.dart';
import 'package:flutter_scheduler/login/screen.dart';

/// Widget to handle the login problem:
///  - If user is logged in, then app shows the user's workspace.
///  - Else, app shows the login screen.
class Landing extends StatelessWidget {
  const Landing({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
