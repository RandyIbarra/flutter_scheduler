import 'package:flutter/material.dart';

import 'package:flutter_scheduler/buttons/classroomschedulebutton.dart';

class ClassroomWeekScreen extends StatefulWidget {
  const ClassroomWeekScreen({
    Key? key, 
    required this.activity_schedules,
    required this.classroom_name,
    required this.classroom,
    required this.updateClassroom,
  }) : super(key: key);
  
  final Map classroom;
  final String classroom_name;
  final List<String> activity_schedules;
  final ValueChanged<Map> updateClassroom; 

  @override
  State<ClassroomWeekScreen> createState() => _ClassroomWeekScreenState();
}

class _ClassroomWeekScreenState extends State<ClassroomWeekScreen> {
  
  late Map classroom;
  
  @override
  void initState() {
    super.initState();
    classroom = widget.classroom;
  }

  void _handleChange(Map new_state){    
    String activity_schedule = new_state["schedule"];
    String activity_name = new_state["name"];
    String activity_day = new_state["day"];

    Map info = {
      "classroom": widget.classroom_name,
      "schedule": activity_schedule,
      "name": activity_name,
      "day": activity_day,
    };
    
    widget.updateClassroom(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.classroom_name)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(child: Text('Schedule'))
                ),
                for(String activity_day in classroom.keys) 
                  Expanded(
                    child: Center(child: Text(activity_day))
                  ),
              ],
            ),
          ),
          for(String activity_schedule in widget.activity_schedules)
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(child: Text(activity_schedule))
                  ),
                  for(String activity_day in classroom.keys)
                    Expanded(
                      child: ClassroomScheduleButton(
                        init_activity_name: classroom[activity_day][activity_schedule], 
                        activity_schedule: activity_schedule,
                        activity_day: activity_day,
                        onChanged: _handleChange
                      )
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}