import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class MeetingRoomScreen extends StatefulWidget {
  final String meetingId;

  MeetingRoomScreen({required this.meetingId});

  @override
  _MeetingRoomScreenState createState() => _MeetingRoomScreenState();
}

class _MeetingRoomScreenState extends State<MeetingRoomScreen> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
    _connectToMeeting();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connectToMeeting() async {
    // Logic to connect to WebRTC server using your backend signaling server
    // (setup signaling, ice candidates, peer connection here).
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meeting: ${widget.meetingId}')),
      body: Column(
        children: [
          Expanded(
            child: RTCVideoView(_localRenderer),
          ),
          Expanded(
            child: RTCVideoView(_remoteRenderer),
          ),
        ],
      ),
    );
  }
}
