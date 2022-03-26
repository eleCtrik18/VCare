import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:v_care/services/firebase/auth_methods.dart';

import '../firebase/firestore_methods.dart';

class JitsiMeetMethods {
  final FireStoreMethods _firestoreMethods = FireStoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = 'Chetan Singh';
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = '_authMethods.user.email'
        ..userAvatarURL =
            'https://firebasestorage.googleapis.com/v0/b/vcare-663a2.appspot.com/o/profilePics%2FVfdxAuBDOzfhGJksBBR1hbv6n5r1?alt=media&token=ea62605e-79b2-494b-a9b8-e8223c216e77'
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
