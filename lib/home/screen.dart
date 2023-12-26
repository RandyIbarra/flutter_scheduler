// flutter
import 'package:flutter/material.dart';
import 'package:flutter_scheduler/login/screen.dart';
// external packages
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
// this project
import 'package:flutter_scheduler/classroom/listing_screen.dart';
import 'package:flutter_scheduler/activities/listing_screen.dart';

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
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              arrowColor: const Color.fromRGBO(0, 0, 0, 0),
              onDetailsPressed: () async {
                const url = "http://www.demat.ugto.mx/";
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              currentAccountPicture: CircleAvatar(
                child: Image.asset('ugto.png'),
              ),
              accountName: const Text('Universidad de Guanajuato'),
              accountEmail: const Text('demat@ugto.mx'),
            ),
            const Spacer(),
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
          (_) => Navigator.of(context).pushAndRemoveUntil(
            // push login screen
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            // remove all other routes
            (route) => false,
          ),
        );
  }
}
