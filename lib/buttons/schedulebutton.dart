import 'package:flutter/material.dart';

class ScheduleButton extends StatefulWidget {
  const ScheduleButton({
    Key? key, 
    required this.init_activity_name,
    required this.activity_classroom,
    required this.activity_schedule,
    required this.activity_day,
    required this.onChanged
  }) : super(key: key);

  final String activity_day;
  final String activity_schedule;
  final String activity_classroom;
  final String init_activity_name;
  final ValueChanged<Map> onChanged;

  @override
  State<ScheduleButton> createState() => _ScheduleButton();
}

class _ScheduleButton extends State<ScheduleButton> {
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
                          "classroom": widget.activity_classroom,
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