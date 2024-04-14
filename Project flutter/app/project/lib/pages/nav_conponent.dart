import 'package:flutter/material.dart';

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
