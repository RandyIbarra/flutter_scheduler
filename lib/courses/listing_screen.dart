// flutter
import 'package:flutter/material.dart';
// external packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/models/course.dart';
import 'package:flutter_scheduler/courses/course_editor.dart';

class CourseListingScreen extends StatelessWidget {
  const CourseListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Courses')),
      ),
      body: Center(
        child: DocumentStreamBuilder<List<Course>>(
          stream: courseListStream(),
          builder: (context, courses) {
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) => Card(
                elevation: 5.0,
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseEditor(
                        course: courses[index],
                      ),
                    ),
                  ),
                  title: Text(courses[index].name),
                  subtitle: Text(courses[index].id),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                            'Are you sure you want to delete this course?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            CustomAsyncButton(
                              onPressed: () => FirebaseFirestore.instance
                                  .collection('courses')
                                  .doc(courses[index].id)
                                  .delete(),
                              onSuccess: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content:
                                        const Text('Course deleted correctly'),
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
            builder: (context) => CourseEditor(
              course: Course(),
            ),
          ),
        ),
        label: const Text('New course'),
      ),
    );
  }

  Stream<List<Course>> courseListStream() {
    final source = FirebaseFirestore.instance.collection('courses').snapshots();
    Stream<List<Course>> courseListStream = source.map((document) {
      return document.docs.map((e) => Course.fromMap(e.data())).toList();
    });
    return courseListStream;
  }
}
