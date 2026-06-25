import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_methods.dart';
import 'package:zoom/screens/history_meeting_screen.dart';
import 'package:zoom/screens/meeting_screen.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/custom_button.dart';

import '../widgets/home_meeting_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final AuthMethods _authMethods = AuthMethods();
  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }
  late List<Widget> pages=[
     MeetingScreen(),
    const HistoryMeetingScreen(),
    Text('Contacts'),
    CustomButton(text: 'Logout', onPressed: ()=>{
      _authMethods.signOut(),
    })
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
      ),

      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Meet & Chat'),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
