import 'package:flutter/material.dart';
import 'package:flutter_scheduler/app.dart';

void main() {
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

  Map college = {
    "activity_days": activityDays,
    "activity_schedules": activitySchedules,
    "activity_classrooms": activityClassrooms,
    "info": info
  };

  runApp(SchedulerApp(college: college));
}
