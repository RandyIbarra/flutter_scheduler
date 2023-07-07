// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_scheduler/app.dart';

void main() {
  List<String> activity_classrooms = [
    'Seminarios',
    'Astrofisica',
    'DEMAT-3',
    'DEMAT-4',
    'DEMAT-5',
    'DEMAT-6',
    'DEMAT-7',
    'DEMAT-8'
  ];
  List<String> activity_days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  List<String> activity_schedules = [
    '08:00-09:20',
    '09:30-10:50',
    '11:00-12:20',
    '12:30-13:50',
    '15:00-16:20'
  ];

  Map info = {};
  for (String classroom_name in activity_classrooms) {
    Map classroom = {};
    for (String activity_day in activity_days) {
      Map days = {};
      for (String activity_schedule in activity_schedules) {
        days[activity_schedule] = '';
      }
      classroom[activity_day] = days;
    }
    info[classroom_name] = classroom;
  }

  Map college = {
    "activity_days": activity_days,
    "activity_schedules": activity_schedules,
    "activity_classrooms": activity_classrooms,
    "info": info
  };
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(college: college),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
