import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  final String meetingId;
  final TextEditingController _controller = TextEditingController();

  ChatScreen(this.meetingId);

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('meetings')
          .doc(meetingId)
          .collection('messages')
          .add({
        'text': text,
        'createdAt': Timestamp.now(),
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('meetings')
                  .doc(meetingId)
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatSnapshot.data?.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs?.length,
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text(chatDocs![index]['text']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message...'),
                  ),
                ),
                IconButton(onPressed: _sendMessage, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
