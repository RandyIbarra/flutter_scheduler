import 'package:flutter/material.dart';

import 'package:flutter_scheduler/screens/mainscreen.dart';

class SchedulerApp extends StatefulWidget {
  const SchedulerApp({
    Key? key,
    required this.college,
  }) : super(key: key);

  final Map college;

  @override
  State<SchedulerApp> createState() => _SchedulerAppState();
}

class _SchedulerAppState extends State<SchedulerApp> {
  late Map college;

  @override
  void initState() {
    super.initState();
    college = widget.college;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(college: college),
    );
  }
}
