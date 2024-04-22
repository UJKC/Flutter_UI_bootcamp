import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/Todo.dart';
import 'package:http/http.dart' as http;
    
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
  }
}



class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Todo> TodoList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        TodoList = list.map((model) => Todo.fromJson(model)).toList();
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