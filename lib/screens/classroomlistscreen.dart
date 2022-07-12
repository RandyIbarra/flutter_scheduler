import 'package:flutter/material.dart';

import 'package:flutter_scheduler/screens/classroomweekscreen.dart';

class ClassroomListScreen extends StatefulWidget {
  const ClassroomListScreen ({
    Key? key,
    required this.college,
    required this.updateCollege,
  }) : super(key: key);

  final Map college;
  final ValueChanged<Map> updateCollege; 

  @override
  State<ClassroomListScreen> createState() => _ClassroomListScreenState();
}
class _ClassroomListScreenState extends State<ClassroomListScreen>{
  
  late Map college;
 
  @override
  void initState() {
    super.initState();
    college = widget.college;
  }

  void _updateClassroomm(Map new_state){
    widget.updateCollege(new_state);
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
                          MaterialPageRoute(builder: (context) => ClassroomWeekScreen(
                            activity_schedules: college["activity_schedules"],
                            classroom_name: classroom_name, 
                            classroom: college["info"][classroom_name], 
                            updateClassroom: _updateClassroomm
                          )),
                        );
                      },
                      child: Text(classroom_name),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}