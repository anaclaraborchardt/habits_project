import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testing/services/UserPostButton.dart';


class PostHabits extends StatelessWidget {
  Future<void> _postHabits(String habitName) async {
    Map<String, dynamic> habit = {
      "name": habitName,
      "user": {"id": 1}
    };

    String jsonHabit = jsonEncode(habit);

    var url = 'http://localhost:8080/habit';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Hábito postado com sucesso!');
    } else {
      debugPrint('Falha ao postar hábito');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _habitController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _habitController,
            decoration: const InputDecoration(labelText: 'Habit Name'),
          ),
          ElevatedButton(
            onPressed: () {
              final habitName = _habitController.text.trim();
              _postHabits(habitName);
            },
            child: const Text('Post Habit'),
          )
        ],
      ),
    );
  }
}