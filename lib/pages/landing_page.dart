import 'package:flutter/material.dart';
import 'package:nurse_app/pages/home_page.dart';
import 'package:nurse_app/pages/profile/profile_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  List<Widget> list = [
    const HomePage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}
