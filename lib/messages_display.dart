import 'package:flutter/material.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesPage extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {


    String? messageText;
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages Page'),
        actions: [
          IconButton(
              onPressed: () => {
              messagesStreams()
              },
              icon: Icon(Icons.download)
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
          onChanged: (value) {
            messageText = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
              ),
            )
          ),
          ElevatedButton(
            child: Text('Send'),
            onPressed: () {
              _firestore.collection('messages').add(
                {
                  'recieverID': 2,
                  'senderID': 1,
                  'text': messageText
                }
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                List<Text> messagesWidget = [];

                if (!snapshot.hasData) {
                  // Add spinner
                }

                final messages = snapshot.data!.docs;
                for (var message in messages) {
                  final messageText = message.get('text');
                  final messageWidget = Text(messageText);
                  messagesWidget.add(messageWidget);
                }

                return Column(
                  children: messagesWidget,
                );
              }
          )
        ],
      ),
    );
  }
  // Get Messages by calling it
  void getMessages() async{
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
}