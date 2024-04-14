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
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 3) {
        _logout(context);
      }
    });

    if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeatherPage()),
      );
    } else if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoteList()),
      );
    } else if (_selectedIndex == 2) {
      // Navigate to settings page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
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
            Text('Welcome, ${widget.username}!'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationComponent(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
        items: [
          NavigationItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          NavigationItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
          NavigationItem(
            icon: Icon(Icons.settings), // Add icon for settings
            label: 'Settings', // Change label to 'Settings'
          ),
          NavigationItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}

class NavigationComponent extends StatelessWidget {
  final List<NavigationItem> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NavigationComponent({
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemSelected,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: item.icon,
          label: item.label,
        );
      }).toList(),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    );
  }
}

class NavigationItem {
  final Widget icon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.label,
  });
}
