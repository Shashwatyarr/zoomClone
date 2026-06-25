import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_methods.dart';
import 'package:zoom/resources/jitsi_meet_methods.dart';
import 'package:zoom/utils/colors.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  late TextEditingController meetingIdController;
  late TextEditingController nameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user?.displayName ?? '',
    );
  }

  @override
  void dispose() {
    meetingIdController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _joinMeeting() {
    if (meetingIdController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a Room ID"),
        ),
      );
      return;
    }

    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text.trim(),
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'Join Meeting',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                filled: true,
                fillColor: secondaryBackgroundColor,
                border: InputBorder.none,
                hintText: "Room ID",
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                filled: true,
                fillColor: secondaryBackgroundColor,
                border: InputBorder.none,
                hintText: "Name",
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),

          const SizedBox(height: 20),

          SwitchListTile(
            title: const Text("Mute Audio"),
            value: isAudioMuted,
            onChanged: (value) {
              setState(() {
                isAudioMuted = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text("Turn Off Video"),
            value: isVideoMuted,
            onChanged: (value) {
              setState(() {
                isVideoMuted = value;
              });
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _joinMeeting,
            child: const Text("Join Meeting"),
          ),
        ],
      ),
    );
  }
}