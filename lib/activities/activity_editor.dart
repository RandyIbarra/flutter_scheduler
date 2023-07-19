// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// this project
import 'package:flutter_scheduler/models/classroom.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ActivityEditor extends StatefulWidget {
  const ActivityEditor({
    super.key,
    required this.activity,
  });

  final Activity activity;

  @override
  State<ActivityEditor> createState() => _ActivityEditorState();
}

class _ActivityEditorState extends State<ActivityEditor> {
  late final activityIdController = TextEditingController(
    text: widget.activity.id,
  );

  late final activityNameController = TextEditingController(
    text: widget.activity.name,
  );

  late final personInChargeController = TextEditingController(
    text: widget.activity.personInCharge,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: [
                const Text('Activity id :'),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: activityIdController,
                    onSubmitted: (value) => widget.activity.id = value,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Actiity name :'),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: activityNameController,
                    onSubmitted: (value) => widget.activity.name = value,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Person in charge :'),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: personInChargeController,
                    onSubmitted: (value) =>
                        widget.activity.personInCharge = value,
                  ),
                ),
              ],
            ),
            CustomAsyncButton(
              onPressed: () => FirebaseFirestore.instance
                  .collection('activities')
                  .doc(widget.activity.id)
                  .set(
                    widget.activity.toMap()!,
                  ),
              onSuccess: () => Navigator.of(context).pop(),
              buttonText: 'Save',
            )
          ],
        ),
      ),
    );
  }
}
