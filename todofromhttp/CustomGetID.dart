import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/MyStatefulWidget.dart';
import 'package:untitled/Todo.dart';
    
class CustomGetId extends StatefulWidget {
  const CustomGetId({super.key});

  @override
  _CustomGetIdState createState() => _CustomGetIdState();
}

class _CustomGetIdState extends State<CustomGetId> {
  final TextEditingController _textController = TextEditingController();
  List<Todo> TodoList = [];

  void getCharactersfromApi(todoid) async {
    int? todoId = int.tryParse(todoid);
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        TodoList = list
          .map((model) => Todo.fromJson(model))
          .where((todo) => todo.userId == todoId) // Filter completed todos
          .toList();
      });
      print(TodoList[0].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Get userId'),
      ),
      body: Container(
        child: Column(
          children: [
            const Text("Enter userId"),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter your Todo userID',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Access the text using the controller's text property
                getCharactersfromApi(_textController.text);
              },
              child: const Text('Submit'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: TodoList.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo repo = TodoList[index];

                  return ListTile(
                    title: Text(repo.title),
                    subtitle: Text(repo.completed.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}