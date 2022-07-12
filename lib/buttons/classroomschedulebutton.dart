import 'package:flutter/material.dart';

class ClassroomScheduleButton extends StatefulWidget {
  const ClassroomScheduleButton({
    Key? key, 
    required this.init_activity_name,
    required this.activity_schedule,
    required this.activity_day,
    required this.onChanged
  }) : super(key: key);

  final String activity_day;
  final String activity_schedule;
  final String init_activity_name;
  final ValueChanged<Map> onChanged;

  @override
  State<ClassroomScheduleButton> createState() => _ClassroomScheduleButton();
}

class _ClassroomScheduleButton extends State<ClassroomScheduleButton> {
  late TextEditingController _controller;
  late String _current_activity_name;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.init_activity_name);
    _current_activity_name = _controller.text;
  }

  Widget build(BuildContext context){
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.3,
        child: new TextField(
          controller: _controller,
          textAlign: TextAlign. center,
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: Text(
                      'You typed "$value".'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        _current_activity_name = _controller.text;
                        Map info = {
                          "day": widget.activity_day,
                          "schedule": widget.activity_schedule,
                          "name": _current_activity_name
                        };
                        widget.onChanged(info);
                        Navigator.pop(context);
                      },
                      child: const Text('Accept'),
                    ),
                    TextButton(
                      onPressed: () {
                        _controller.text = _current_activity_name;
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}