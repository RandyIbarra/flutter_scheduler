// dart
import 'dart:math';
//flutter
import 'package:flutter/material.dart';
// external packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/models/course.dart';
import 'package:flutter_scheduler/models/activity.dart';

/// Course editor screen.
class ActivityEditor extends StatefulWidget {
  final Activity activity;

  const ActivityEditor({
    super.key,
    required this.activity,
  });

  @override
  State<ActivityEditor> createState() => _ActivityEditorState();
}

class _ActivityEditorState extends State<ActivityEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: min(400, MediaQuery.of(context).size.width),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // id field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CourseSelector(
                  courseId: widget.activity.courseId,
                  update: (newSelectedCourseId) {
                    widget.activity.courseId = newSelectedCourseId;
                  },
                ),
              ),

              // password field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TeacherListEditor(
                  teachers: widget.activity.teachers,
                ),
              ),

              // password field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Group: ${widget.activity.group ?? 'Unique'}'),
              ),

              // save button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAsyncButton(
                  buttonText: 'Save',
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );

                    return FirebaseFirestore.instance
                        .collection('activities')
                        .doc(widget.activity.activityId)
                        .set(
                          widget.activity.toMap(),
                          SetOptions(merge: true),
                        );
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Course editor screen.
class ActivityCreator extends StatefulWidget {
  const ActivityCreator({
    super.key,
  });

  @override
  State<ActivityCreator> createState() => _ActivityCreatorState();
}

class _ActivityCreatorState extends State<ActivityCreator> {
  final formKey = GlobalKey<FormState>();

  // text controllers
  final groupController = TextEditingController();

  String? selectedCourseId;
  final List<String> teachers = List<String>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity creator'),
      ),
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
                  child: CourseSelector(
                    update: (newSelectedCourseId) {
                      selectedCourseId = newSelectedCourseId;
                    },
                  ),
                ),
//

                // password field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: groupController,
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: 'Group (optionally)',
                    ),
                  ),
                ),

                //// password field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TeacherListEditor(
                    teachers: teachers,
                  ),
                ),

                const Spacer(),

                // save button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomAsyncButton(
                    buttonText: 'Save',
                    onPressed: () async {
                      if (selectedCourseId != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        late String activityId;
                        if (groupController.text == '') {
                          activityId = '$selectedCourseId-unique';
                        } else {
                          activityId =
                              '$selectedCourseId-${groupController.text}';
                        }

                        return FirebaseFirestore.instance
                            .collection('activities')
                            .doc(activityId)
                            .set(
                              Activity(
                                group: groupController.text != ''
                                    ? groupController.text
                                    : null,
                                teachers: teachers,
                                activityId: activityId,
                                courseId: selectedCourseId!,
                              ).toMap(),
                              SetOptions(merge: true),
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please, choose a course'),
                          ),
                        );
                        return Future.error(
                          Exception('Invalid course'),
                        );
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
    groupController.dispose();
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

class CourseSelector extends StatefulWidget {
  final String? courseId;
  final void Function(String newSelectedCourseId) update;

  const CourseSelector({
    super.key,
    this.courseId,
    required this.update,
  });

  @override
  State<CourseSelector> createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<CourseSelector> {
  late String? selectedCourseId = widget.courseId;
  @override
  Widget build(BuildContext context) {
    return DocumentFutureBuilder<List<Course>>(
      future: FirebaseFirestore.instance.collection('courses').get().then(
            (value) => value.docs
                .map(
                  (e) => Course.fromMap(e.data()),
                )
                .toList(),
          ),
      builder: (context, courses) {
        return DropdownButton<String>(
          value: selectedCourseId,
          underline: Container(), //remove underline
          isExpanded: true, //make true to make width 100%
          hint: const Text('Select course'),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedCourseId = value;
                widget.update(selectedCourseId!);
              });
            }
          },
          items: [
            for (Course course in courses)
              DropdownMenuItem(
                value: course.id,
                child: Text(course.name),
              ),
          ],
        );
      },
    );
  }
}

class TeacherListEditor extends StatefulWidget {
  final List<String> teachers;

  const TeacherListEditor({
    super.key,
    required this.teachers,
  });

  @override
  State<TeacherListEditor> createState() => _TeacherListEditorState();
}

class _TeacherListEditorState extends State<TeacherListEditor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Teachers:'),
          widget.teachers.isEmpty
              ? const Text('Not assigned yet')
              : Expanded(
                  child: ListView.builder(
                    itemCount: widget.teachers.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(widget.teachers[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            setState(() => widget.teachers.removeAt(index)),
                      ),
                    ),
                  ),
                ),
          ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  final newTeacherController = TextEditingController();
                  return AlertDialog(
                    title: const Center(
                      child: Text('Adding teacher to activity'),
                    ),
                    content: TextField(
                      controller: newTeacherController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(
                          () => widget.teachers.add(newTeacherController.text),
                        ),
                        child: const Text('OK'),
                      )
                    ],
                  );
                },
              );
            },
            child: const Text('Add teacher'),
          )
        ],
      ),
    );
  }
}
