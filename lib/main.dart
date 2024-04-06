import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testing/services/UserPostButton.dart';
import 'package:testing/services/PostHabits.dart';
import 'package:testing/services/PostQuantityDaily.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Post Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Post Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserPostButton(),
              SizedBox(height: 20),
              PostHabits(),
              SizedBox(height: 20),
              PostQuantityDaily(),
              SizedBox(height: 20),
              GetUser()
            ],
          ),
        ),
      ),
    );
  }
}
