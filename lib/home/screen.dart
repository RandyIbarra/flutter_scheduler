// flutter
import 'package:flutter/material.dart';
// this project
import 'package:flutter_scheduler/home/scheduler_drawer.dart';

import 'package:flutter_scheduler/courses/listing_screen.dart';
import 'package:flutter_scheduler/activities/listing_screen.dart';

/// Home screen with main menu.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduler'),
      ),
      drawer: const SchedulerDrawer(),
      body: ListView(
        children: [
          Card(
            elevation: 5.0,
            child: ListTile(
              title: const Text('Courses'),
              subtitle: const Text('See, create, edit and delete UG courses'),
              trailing: const Icon(Icons.golf_course),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CourseListingScreen(),
                ),
              ),
            ),
          ),
          //Card(
          //  elevation: 5.0,
          //  child: ListTile(
          //    title: const Text('Classrooms'),
          //    subtitle: const Text('See, create, edit and delete classrooms'),
          //    trailing: const Icon(Icons.class_sharp),
          //    onTap: () => Navigator.of(context).push(
          //      MaterialPageRoute(
          //        builder: (context) => const ClassroomListingScreen(),
          //      ),
          //    ),
          //  ),
          //),
          Card(
            elevation: 5.0,
            child: ListTile(
              title: const Text('Activities'),
              subtitle: const Text(
                'See, create, edit and delete schoolar activities',
              ),
              trailing: const Icon(Icons.class_sharp),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ActivityListingScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
