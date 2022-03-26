import 'dart:math';

import 'package:flutter/material.dart';
import 'package:v_care/screens/user/features_screen/Video%20Meet/video_call_screen.dart';
import 'package:v_care/services/meet_services/jitsi_methods.dart';
import 'package:v_care/widgets/home_meeting.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    print("createNewMeeting");
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const VideoCallScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: createNewMeeting,
              text: 'New Meeting',
              icon: Icons.videocam,
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              text: 'Join Meeting',
              icon: Icons.add_box_rounded,
            ),
            // HomeMeetingButton(
            //   onPressed: () {},
            //   text: 'Schedule',
            //   icon: Icons.calendar_today,
            // ),
            // HomeMeetingButton(
            //   onPressed: () {},
            //   text: 'Share Screen',
            //   icon: Icons.arrow_upward_rounded,
            // ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with just a click!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
