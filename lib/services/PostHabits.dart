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

class Habit {
  final int id;
  final String name;

  const Habit({required this.id, required this.name});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name} => Habit(id: id, name: name),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }
}

class GetHabit extends StatelessWidget {
  Future<List<Habit>> _getHabit() async {
    var url = 'http://localhost:8080/habit/user/1';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      debugPrint('GET DE HÁBITO FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM HÁBITO] ${response.statusCode}');
    }

    List<Habit> habitsList = [];

    for (var habitFor in responseJson) {
      habitsList.add(Habit.fromJson(habitFor));
    }
    return habitsList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              final habit = await _getHabit();
              if (habit != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Detalhes do Hábito'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Obter Hábitos'),
          ),
        ],
      ),
    );
  }
}
