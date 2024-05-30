import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'notelist_page.dart';
import 'weather_page.dart';
import 'settings_page.dart'; // Import the settings page

class Home extends StatefulWidget {
  final String username;

  Home({required this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _navigateTo(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoteList()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeatherPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    } else if (index == 3) {
      _logout(context);
    }
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here, such as clearing user data or navigating to the login page
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome, ${widget.username}!',
                  textStyle: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.note),
                  label: Text('Notes'),
                  onPressed: () {
                    _navigateTo(0);
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.wb_sunny),
                  label: Text('Weather'),
                  onPressed: () {
                    _navigateTo(1);
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                  onPressed: () {
                    _navigateTo(2);
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Logout'),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
