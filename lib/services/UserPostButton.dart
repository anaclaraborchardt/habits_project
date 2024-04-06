import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class UserPostButton extends StatelessWidget {
  Future<void> _postUser(String userName) async {
    Map<String, dynamic> user = {'name': userName};

    String jsonUser = jsonEncode(user);

    var url = 'http://localhost:8080/user';

    var headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonUser);

    if (response.statusCode == 200) {
      debugPrint('Usuário postado com sucesso!');
    } else {
      debugPrint('Falha ao postar usuário: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _userController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _userController,
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
          ElevatedButton(
            onPressed: () {
              final userName = _userController.text.trim();
              _postUser(userName);
            },
            child: const Text('Post User'),
          )
        ],
      ),
    );
  }
}

class User {
  final int id;
  final String name;

  const User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
      } =>
        User(
          id: id,
          name: name,
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}

class GetUser extends StatelessWidget {
  Future<User> _getUser() async {
    var url = 'http://localhost:8080/user';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    return User.fromJson(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _getUserController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              final userName = _getUserController.text.trim();
              _getUser();
            },
            child: const Text('Get User'),
          )
        ],
      ),
    );
  }
}
