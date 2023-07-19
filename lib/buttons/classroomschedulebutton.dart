import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_scheduler/models/classroom.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ClassroomScheduleButton extends StatefulWidget {
  const ClassroomScheduleButton({
    super.key,
    required this.activity,
    required this.onChanged,
  });

  final Activity activity;
  final void Function(Activity activity) onChanged;

  @override
  State<ClassroomScheduleButton> createState() => _ClassroomScheduleButton();
}

class _ClassroomScheduleButton extends State<ClassroomScheduleButton> {
  late final activityNameNotifier = ValueNotifier<String>(widget.activity.name);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.4,
        child: ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SizedBox(
                width: 300,
                height: 400,
                child: Column(
                  children: [
                    const Text('Select an activity'),
                    Expanded(
                      child: DocumentFutureBuilder<List<Activity>>(
                        future: FirebaseFirestore.instance
                            .collection('activities')
                            .get()
                            .then(
                              (value) => value.docs
                                  .map(
                                    (e) => Activity.fromMap(e.data()),
                                  )
                                  .toList(),
                            ),
                        builder: (context, activities) {
                          return ListView.builder(
                            itemCount: activities.length,
                            itemBuilder: (context, index) => Card(
                              child: ListTile(
                                onTap: () {
                                  widget.activity.id = activities[index].id;
                                  widget.activity.name = activities[index].name;
                                  widget.activity.personInCharge =
                                      activities[index].personInCharge;
                                  // set sub state
                                  activityNameNotifier.value =
                                      activities[index].name;
                                  widget.onChanged(widget.activity);
                                  Navigator.of(context).pop();
                                },
                                title: Text(activities[index].name),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: SizedBox(
            width: 200,
            child: ValueListenableBuilder<String>(
              valueListenable: activityNameNotifier,
              builder: (context, value, child) {
                return Text(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
