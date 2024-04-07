import 'package:flutter/material.dart';

import 'notelist_page.dart';
import 'weather_page.dart';

class Home extends StatelessWidget {
  final String username;

  Home({required this.username});

  void _logout(BuildContext context) {
    // Add your logout logic here, such as clearing user data or navigating to the login page
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Today\'s Weather'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage()),
                );
              },
            ),
            ListTile(
              title: Text('Notes'), // Add a button for the NoteList component
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteList()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'), // Add a button for logging out
              onTap: () => _logout(context),
            ),
            // Add more list tiles for other menu items if needed
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $username!'),
          ],
        ),
      ),
    );
  }
}
