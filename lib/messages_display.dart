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
                mySpecificMessage()
              },
              icon: Icon(Icons.download)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').where('recieverID', isEqualTo: 2).snapshots(),
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
          ),
          TextField(
              onChanged: (value) {
                messageText = value;
              },
              decoration: const InputDecoration(
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
                    'recieverID': 3,
                    'senderID': 1,
                    'text': messageText
                  }
              );
            },
          )
        ],
      ),
    );
  }
  // Get Messages by calling it using get()
  void getMessages() async{
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  // Messages changed streamly and no need to recall the query everytime
  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  // Query to fetch message according to specific 'recieverID'
  void mySpecificMessage() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('recieverID', isEqualTo: 2)
        .get();

// Print the resulting documents
    querySnapshot.docs.forEach((doc) {
      print(doc.data());
    });
  }
}