// flutter
import 'package:flutter/material.dart';
// this project
import 'package:flutter_scheduler/login/screen.dart';

/// Main [Widget] for this app.
class SchedulerApp extends StatelessWidget {
  const SchedulerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SchedulerApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
