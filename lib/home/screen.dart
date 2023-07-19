import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scheduler/activities/listing_screen.dart';
import 'package:flutter_scheduler/classroom/listing_screen.dart';

/// Home screen with main menu.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduler'),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {},
            icon: const Icon(Icons.person),
            label: const Text('Hello user'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Log out'),
              trailing: const Icon(Icons.logout),
              onTap: () => _signOut(),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 20,
            child: ListTile(
              title: const Text('Classrooms'),
              subtitle: const Text('See, create, edit and delete classrooms'),
              trailing: const Icon(Icons.class_sharp),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ClassroomListingScreen(),
                ),
              ),
            ),
          ),
          Card(
            elevation: 20,
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

  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut().then(
          (_) => Navigator.of(context).popUntil(
            (route) => route.isFirst,
          ),
        );
  }
}
