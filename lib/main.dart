import 'package:flutter/material.dart';
import 'package:flutter_scheduler/app.dart';

void main() {
  List<String> activity_classrooms = ['Seminarios', 'Astrofisica', 'DEMAT-3', 'DEMAT-4', 'DEMAT-5', 'DEMAT-6', 'DEMAT-7', 'DEMAT-8'];
  List<String> activity_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List<String> activity_schedules = ['08:00-09:20', '09:30-10:50', '11:00-12:20', '12:30-13:50', '15:00-16:20'];
  
  Map info = {};
  for(String classroom_name in activity_classrooms){
    Map classroom = {};
    for(String activity_day in activity_days){
      Map days = {};
      for(String activity_schedule in activity_schedules){
        days[activity_schedule] = '';
      }
      classroom[activity_day] = days;
    }
    info[classroom_name] = classroom;
  }

  Map college = {
    "activity_days": activity_days,
    "activity_schedules": activity_schedules,
    "activity_classrooms": activity_classrooms, 
    "info": info
  };

  runApp(MyApp(college: college));
}