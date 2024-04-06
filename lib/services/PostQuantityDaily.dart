import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testing/services/UserPostButton.dart';


class PostQuantityDaily extends StatelessWidget {
  Future<void> _postQuantityDaily(int currentStatus) async {
    Map<String, dynamic> quantity = {
      "habit": {"id": 1},
      "quantity": {"currentStatus": currentStatus}
    };

    String jsonHabit = jsonEncode(quantity);
    var url = 'http://localhost:8080/dailyGoal';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonHabit);

    if (response.statusCode == 200) {
      debugPrint('Meta do dia atualizada!');
    } else {
      debugPrint('Meta do dia atualizada!');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _quantityGoal = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            controller: _quantityGoal,
            decoration: const InputDecoration(labelText: 'Update goal'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantityGoal = _quantityGoal.hashCode.abs();
              _postQuantityDaily(quantityGoal);
            },
            child: const Text('Post my goal'),
          )
        ],
      ),
    );
  }
}