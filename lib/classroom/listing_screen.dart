// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// this project
import 'package:flutter_scheduler/models/classroom.dart';
import 'package:flutter_scheduler/classroom/classroom_editor.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ClassroomListingScreen extends StatelessWidget {
  const ClassroomListingScreen({super.key});

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
          child: DocumentFutureBuilder<List<Classroom>>(
            future:
                FirebaseFirestore.instance.collection('classrooms').get().then(
                      (value) => value.docs
                          .map((e) => Classroom.fromMap(e.data()))
                          .toList(),
                    ),
            builder: (context, classrooms) {
              return ListView.builder(
                itemCount: classrooms.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassroomEditor(
                          classroom: classrooms[index],
                        ),
                      ),
                    ),
                    title: Text(classrooms[index].id),
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
