import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Todo.dart';
    
class CustomGet extends StatefulWidget {
  const CustomGet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomGetState createState() => _CustomGetState();
}

class CharacterApi {
  static Future getCharacters(todoid) {
    return http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos/$todoid"));
  }
}

class _CustomGetState extends State<CustomGet> {
  // ignore: non_constant_identifier_names
  // Later in your code, when you have the required data
  Todo todo_custom = Todo(
    userId: 1, // Provide userId value
    id: 1, // Provide id value
    title: 'Default Title', // Provide title value
    completed: false, // Provide completed value
  );

  // Now you can safely access todo_custom
  final TextEditingController _textController = TextEditingController();

  void getCharactersfromApi(todoid) async {
    CharacterApi.getCharacters(todoid).then((response) {
      setState(() {
        todo_custom = Todo.fromJson(json.decode(response.body));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Get'),
      ),
      body: ListView(
        children: [
          const Text("Enter specific todo ID"),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter your Todo ID',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Access the text using the controller's text property
              getCharactersfromApi(_textController.text);
            },
            child: const Text('Submit'),
          ),
          ListTile(
            title: Text(todo_custom.title), // Use null-aware operators to handle null values
            subtitle: Text(todo_custom.completed.toString()), // Use null-aware operators to handle null values
          )
        ],
      ),
    );
  }
}