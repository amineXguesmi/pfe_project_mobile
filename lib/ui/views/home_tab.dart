import 'package:flutter/material.dart';
import 'package:mobile_app/ui/views/favorite/favorites_screen.dart';
import 'package:mobile_app/ui/views/profile/profile_settings_screen.dart';

import 'home/home_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.initialIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
