// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scheduler/models/activity.dart';
// this project
import 'package:flutter_scheduler/models/classroom.dart';
import 'package:flutter_scheduler/buttons/classroomschedulebutton.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ClassroomEditor extends StatefulWidget {
  const ClassroomEditor({
    super.key,
    required this.classroom,
  });

  final Classroom classroom;

  @override
  State<ClassroomEditor> createState() => _ClassroomEditorState();
}

class _ClassroomEditorState extends State<ClassroomEditor> {
  late final classroomNameController = TextEditingController(
    text: widget.classroom.id,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: EditableTitle(
          initTitle: widget.classroom.id,
          updateTitle: (newTitle) => widget.classroom.id = newTitle,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Center(
                        child: Text('Schedule'),
                      ),
                    ),
                    for (String activityDay
                        in widget.classroom.getActivityDays())
                      Expanded(
                        child: Center(
                          child: Text(activityDay),
                        ),
                      ),
                  ],
                ),
              ),
              for (String activitySchedule
                  in widget.classroom.getActivitySchedules())
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Center(child: Text(activitySchedule))),
                      for (ActivitySchedule activitySchedule in widget.classroom
                          .getActivityScheduleListFromSchedule(
                              activitySchedule))
                        Expanded(
                          child: ClassroomScheduleButton(
                            activity: activitySchedule.activity ?? Activity(),
                            onChanged: (activity) =>
                                activitySchedule.activity = activity,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomAsyncButton(
              onPressed: () => FirebaseFirestore.instance
                  .collection('classrooms')
                  .doc(widget.classroom.id)
                  .set(widget.classroom.toMap()),
              onSuccess: () => Navigator.of(context).pop(),
              buttonText: 'Save',
            ),
          )
        ],
      ),
    );
  }
}

class EditableTitle extends StatefulWidget {
  const EditableTitle({
    super.key,
    required this.initTitle,
    required this.updateTitle,
  });

  final String initTitle;
  final void Function(String newTitle) updateTitle;

  @override
  State<EditableTitle> createState() => _EditableTitleState();
}

class _EditableTitleState extends State<EditableTitle> {
  late final titleController = TextEditingController(
    text: widget.initTitle,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          Text(titleController.text),
          IconButton(
            onPressed: () async => await showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                content: TextField(
                  controller: titleController,
                  onSubmitted: (value) {
                    setState(() => titleController.text = value);
                    widget.updateTitle(value);
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {});
                      widget.updateTitle(titleController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  )
                ],
              ),
            ),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
