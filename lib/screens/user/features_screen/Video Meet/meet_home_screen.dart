import 'package:flutter/material.dart';
import 'package:v_care/configs/colors.dart';
import 'package:v_care/screens/user/features_screen/Video%20Meet/meeting_history.dart';
import 'package:v_care/screens/user/features_screen/Video%20Meet/meeting_screen.dart';

class MeetHomeScreen extends StatefulWidget {
  const MeetHomeScreen({Key? key}) : super(key: key);

  @override
  State<MeetHomeScreen> createState() => _MeetHomeScreenState();
}

class _MeetHomeScreenState extends State<MeetHomeScreen> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    // const HistoryMeetingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: blueColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment_bank,
            ),
            label: 'Meet & Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
