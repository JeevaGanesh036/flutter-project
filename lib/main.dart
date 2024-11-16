import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'meeting_screen.dart';
import 'meeting_room_screen.dart';
import 'chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlutterMeetApp());
}

class FlutterMeetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterMeet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/meeting': (context) => MeetingScreen(),
        '/meeting-room': (context) => MeetingRoomScreen(meetingId: ''),
        '/chat': (context) => ChatScreen(''),
      },
    );
  }
}
