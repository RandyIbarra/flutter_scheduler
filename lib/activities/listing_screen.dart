// flutter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// own widgets (private)
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/models/classroom.dart';
import 'package:flutter_scheduler/activities/activity_editor.dart';

class ActivityListingScreen extends StatefulWidget {
  const ActivityListingScreen({super.key});

  @override
  State<ActivityListingScreen> createState() => _ActivityListingScreenState();
}

class _ActivityListingScreenState extends State<ActivityListingScreen> {
  final Future<List<Activity>> activityList =
      FirebaseFirestore.instance.collection('activities').get().then(
            (value) => value.docs
                .map(
                  (e) => Activity.fromMap(e.data()),
                )
                .toList(),
          );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Classrooms')),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.8,
          child: DocumentFutureBuilder<List<Activity>>(
            future: activityList,
            builder: (context, activities) {
              return ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityEditor(
                          activity: activities[index],
                        ),
                      ),
                    ),
                    title: Text(activities[index].name),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
