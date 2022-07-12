import 'package:flutter/material.dart';

import 'package:flutter_scheduler/screens/classroomlistscreen.dart';
import 'package:flutter_scheduler/screens/weekscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.college,
  }) : super(key: key);

  final Map college;

  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  late Map college;

  @override
  void initState(){
    super.initState();
    this.college = widget.college;
  }

  void _updateCollege(Map new_state){
    String day = new_state["day"];
    String name = new_state["name"];
    String schedule = new_state["schedule"];
    String classroom = new_state["classroom"];
    setState(() {
      this.college["info"][classroom][day][schedule] = name;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Main Menu')),
      ),
      body: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0, 
        child: Row(
          children: <Widget>[
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.3,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClassroomListScreen(college: college, updateCollege: _updateCollege)),
                      );
                    },
                    child: const Text('Classrooms'),
                  ),
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.3,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeekScreen(college: college, updateCollege: _updateCollege)),
                      );
                    },
                    child: const Text('Week'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}