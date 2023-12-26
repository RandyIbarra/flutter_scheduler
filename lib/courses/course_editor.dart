// dart
import 'dart:math';
//flutter
import 'package:flutter/material.dart';
// external packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/models/course.dart';

/// Course editor screen.
class CourseEditor extends StatefulWidget {
  final Course course;

  const CourseEditor({
    super.key,
    required this.course,
  });

  @override
  State<CourseEditor> createState() => _CourseEditorState();
}

class _CourseEditorState extends State<CourseEditor> {
  final formKey = GlobalKey<FormState>();

  // text controllers
  late final idController = TextEditingController(
    text: widget.course.id,
  );
  late final nameController = TextEditingController(
    text: widget.course.name,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: min(400, MediaQuery.of(context).size.width),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // id field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: idValidator,
                    controller: idController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Id',
                    ),
                  ),
                ),

                // password field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: nameValidator,
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),

                // save button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomAsyncButton(
                    buttonText: 'Save',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        // update object and save
                        widget.course.id = idController.text;
                        widget.course.name = nameController.text;

                        return FirebaseFirestore.instance
                            .collection('courses')
                            .doc(widget.course.id)
                            .set(
                              widget.course.toMap(),
                              SetOptions(merge: true),
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid id or name.'),
                          ),
                        );
                        return Future.error(
                            Exception('Invalid email or password'));
                      }
                    },
                    onSuccess: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Saved correctly.'),
                        ),
                      );

                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    super.dispose();
  }
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some name';
  }
  return null;
}

String? idValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please, enter some id';
  }
  return null;
}
