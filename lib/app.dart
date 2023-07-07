import 'package:flutter/material.dart';

import 'package:flutter_scheduler/screens/mainscreen.dart';

class SchedulerApp extends StatefulWidget {
  const SchedulerApp({Key? key}) : super(key: key);

  @override
  State<SchedulerApp> createState() => _SchedulerAppState();
}

class _SchedulerAppState extends State<SchedulerApp> {
  late Map<String, dynamic> college;

  @override
  void initState() {
    super.initState();
    List<String> activityClassrooms = [
      'Seminarios',
      'Astrofisica',
      'DEMAT-3',
      'DEMAT-4',
      'DEMAT-5',
      'DEMAT-6',
      'DEMAT-7',
      'DEMAT-8'
    ];
    List<String> activityDays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];
    List<String> activitySchedules = [
      '08:00-09:20',
      '09:30-10:50',
      '11:00-12:20',
      '12:30-13:50',
      '15:00-16:20'
    ];

    Map info = {};
    for (String classroomName in activityClassrooms) {
      Map classroom = {};
      for (String activityDay in activityDays) {
        Map days = {};
        for (String activitySchedule in activitySchedules) {
          days[activitySchedule] = '';
        }
        classroom[activityDay] = days;
      }
      info[classroomName] = classroom;
    }

    college = {
      "activity_days": activityDays,
      "activity_schedules": activitySchedules,
      "activity_classrooms": activityClassrooms,
      "info": info
    };
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
