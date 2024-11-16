import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'meeting_room.dart';

class MeetingScreen extends StatelessWidget {
  final TextEditingController meetingIdController = TextEditingController();
  final String meetingId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join or Create Meeting')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: meetingIdController,
              decoration: InputDecoration(labelText: 'Enter Meeting ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeetingRoomScreen(
                      meetingId: meetingIdController.text,
                    ),
                  ),
                );
              },
              child: Text('Join Meeting'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeetingRoomScreen(
                      meetingId: meetingId,
                    ),
                  ),
                );
              },
              child: Text('Create Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
