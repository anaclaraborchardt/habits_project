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
  final String email;

  const User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email
      } =>
        User(
          id: id,
          name: name,
          email: email
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}

class GetUser extends StatelessWidget {
  Future<User> _getUser() async {
    var url = 'http://localhost:8080/user/1';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      debugPrint('GET DE USUÁRIO FUNCIONANDO!');
    } else {
      debugPrint('FALHA AO DAR GET EM USUÁRIO ${response.statusCode}');
    }
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
            onPressed: () async {
              final user = await _getUser();
              if (user != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Detalhes do Usuário'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('ID: ${user.id}'),
                          Text('Nome: ${user.name}'),
                        ],
                      ),
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
            child: const Text('Obter Usuário'),
          ),
        ],
      ),
    );
  }
}
