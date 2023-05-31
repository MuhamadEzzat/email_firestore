import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_email_system_sample/home_page.dart';
import 'package:firestore_email_system_sample/messages_display.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp( MyApp('https://pub.dev/packages/webview_flutter', '12'));
}

class MyApp extends StatelessWidget {
  final String url;
  final String userId;
  MyApp( this.url,  this.userId);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'homepage',
      routes: {
        'homepage': (context) => HomePage(),
        'messagespage': (context) => MessagesPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future<DocumentSnapshot> getData() async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance
      .collection("users")
      .doc("docID")
      .get();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Scaffold build(BuildContext context)  {
    return Scaffold(
    );
  }
}
