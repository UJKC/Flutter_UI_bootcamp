import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/Todo.dart';
import 'package:untitled/MyStatefulWidget.dart';
    
class MyStatefulWidgetCompleted extends StatefulWidget {
  const MyStatefulWidgetCompleted({super.key});

  @override
  _MyStatefulWidgetCompletedState createState() => _MyStatefulWidgetCompletedState();
}

class _MyStatefulWidgetCompletedState extends State<MyStatefulWidgetCompleted> {
  List<Todo> TodoList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        TodoList = list
          .map((model) => Todo.fromJson(model))
          .where((todo) => todo.completed == true) // Filter completed todos
          .toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharactersfromApi();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("All tasks"),
      ),
      body: ListView.builder(
        itemCount: TodoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(TodoList[index].title),
            subtitle: Text(TodoList[index].completed.toString())
          );
        },
      ),
    );
  }
}