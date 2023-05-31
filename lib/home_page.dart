import 'package:firestore_email_system_sample/messages_display.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Second Page'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagesPage()),
            );
          },
        ),
      ),
    );
  }
}