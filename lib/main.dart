// flutter
import 'package:flutter/material.dart';
// external packages
import 'package:firebase_core/firebase_core.dart';
// this project
import 'firebase_options.dart';
import 'package:flutter_scheduler/app.dart';

/// Main function: Initialize firebase app and run SchedulerApp.
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SchedulerApp());
}
