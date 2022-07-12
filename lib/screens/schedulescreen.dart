import 'package:flutter/material.dart';

import 'package:flutter_scheduler/buttons/schedulebutton.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen ({
    Key? key,
    required this.activity_day,
    required this.activity_schedule,
    required this.college,
    required this.updateSchedule
  }) : super(key: key);

  final String activity_day;
  final String activity_schedule;
  final Map college;
  final ValueChanged<Map> updateSchedule;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>{
  
  late Map college;

  @override
  void initState(){
    super.initState();
    this.college = widget.college;
  }

  void _handleChange(Map new_state){    
    String activity_classroom = new_state["classroom"];
    String activity_schedule = new_state["schedule"];
    String activity_name = new_state["name"];
    String activity_day = new_state["day"];

    Map info = {
      "classroom": activity_classroom,
      "schedule": activity_schedule,
      "name": activity_name,
      "day": activity_day,
    };
    
    widget.updateSchedule(info);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Classrooms')),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.8,
          child: Column(
            children: <Widget>[
              for(String classroom_name in college["activity_classrooms"])
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Center(child: Text(classroom_name))
                      ),
                      Expanded(
                        child: ScheduleButton(
                          init_activity_name: college["info"][classroom_name][widget.activity_day][widget.activity_schedule], 
                          activity_classroom: classroom_name,
                          activity_schedule: widget.activity_schedule,
                          activity_day: widget.activity_day,
                          onChanged: _handleChange
                        )
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}