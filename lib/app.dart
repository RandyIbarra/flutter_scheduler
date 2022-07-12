import 'package:flutter/material.dart';

import 'package:flutter_scheduler/screens/mainscreen.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.college
  }) : super(key: key);

  final Map college;

  @override
  State<MyApp> createState() => _MyAppState();
}  

class _MyAppState extends State<MyApp> {

  late Map college;

  @override
  void initState(){
    super.initState();
    this.college = widget.college;
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