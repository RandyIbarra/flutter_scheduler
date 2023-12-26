// flutter
import 'package:flutter/material.dart';
// external packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/models/course.dart';
import 'package:flutter_scheduler/models/activity.dart';
import 'package:flutter_scheduler/activities/activity_editor.dart';

class ActivityListingScreen extends StatelessWidget {
  const ActivityListingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Activities'),
      ),
      body: Center(
        child: DocumentStreamBuilder<List<Activity>>(
          stream: activityListStream(),
          builder: (context, activities) {
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) => Card(
                elevation: 5.0,
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityEditor(
                        activity: activities[index],
                      ),
                    ),
                  ),
                  title: DocumentFutureBuilder<Course>(
                    future: FirebaseFirestore.instance
                        .collection('courses')
                        .doc(activities[index].courseId)
                        .get()
                        .then((value) {
                      final data = value.data();
                      if (data == null) {
                        throw 'Course ${activities[index].courseId} has null data';
                      } else {
                        return Course.fromMap(data);
                      }
                    }),
                    builder: (context, course) {
                      late final String activityName;
                      if (activities[index].group == null) {
                        activityName = course.name;
                      } else {
                        activityName =
                            '${course.name} - ${activities[index].group}';
                      }
                      return Text(activityName);
                    },
                  ),
                  subtitle: Text(activities[index].teachers.join(', ')),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                            'Are you sure you want to delete this activity?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            CustomAsyncButton(
                              onPressed: () => FirebaseFirestore.instance
                                  .collection('activities')
                                  .doc(activities[index].activityId!)
                                  .delete(),
                              onSuccess: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: const Text(
                                      'Activity deleted correctly',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('OK'),
                                      )
                                    ],
                                  ),
                                );
                              },
                              buttonText: 'OK',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ActivityCreator(),
          ),
        ),
        label: const Text('New activity'),
      ),
    );
  }

  Stream<List<Activity>> activityListStream() {
    final source =
        FirebaseFirestore.instance.collection('activities').snapshots();
    Stream<List<Activity>> activityListStream = source.map((document) {
      return document.docs.map((e) => Activity.fromMap(e.data())).toList();
    });
    return activityListStream;
  }
}
