// flutter
import 'package:flutter/material.dart';
// this project
import 'package:flutter_scheduler/theme.dart';
import 'package:flutter_scheduler/landing.dart';

/// Main [Widget] for this app.
class SchedulerApp extends StatelessWidget {
  const SchedulerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // app settings
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      // main elements
      title: 'SchedulerApp',
      home: const Landing(),
    );
  }
}
