import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import 'auth_methods.dart';
import 'firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  final JitsiMeet _jitsiMeet = JitsiMeet();

  Future<void> createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name;

      if (username.isEmpty) {
        name = _authMethods.user!.displayName!;
      } else {
        name = username;
      }

      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: roomName,
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.user!.email,
          avatar: _authMethods.user!.photoURL,
        ),
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "resolution": 360,
        },
        featureFlags: {
          "welcomepage.enabled": false,
        },
      );

      await _firestoreMethods.addToMeetingHistory(roomName);

      await _jitsiMeet.join(options);
    } catch (e) {
      print("Jitsi Error: $e");
    }
  }
}