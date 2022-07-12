import 'package:flutter/material.dart';

import 'package:flutter_scheduler/screens/schedulescreen.dart';

class WeekScreen extends StatefulWidget {
  const WeekScreen ({
    Key? key,
    required this.college,
    required this.updateCollege,
  }) : super(key: key);

  final Map college;
  final ValueChanged<Map> updateCollege; 

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}
class _WeekScreenState extends State<WeekScreen> {

   late Map college;
 
  @override
  void initState() {
    super.initState();
    college = widget.college;
  }

  void _updateSchedule(Map new_state){
    widget.updateCollege(new_state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Week')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(child: Text('Schedule')),
                ),
                for(var activity_day in college["activity_days"])
                  Expanded(
                    child: Center(child: Text(activity_day)),
                  ),
              ],
            ),
          ),
          for(var activity_schedule in college["activity_schedules"])
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(child: Text(activity_schedule)),
                  ),
                  for(var activity_day in college["activity_days"])
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.9,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.blue,
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScheduleScreen(
                                activity_day: activity_day, 
                                activity_schedule: activity_schedule,
                                college: college, 
                                updateSchedule: _updateSchedule
                              )),
                            );
                          },
                          child: Text('-'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}