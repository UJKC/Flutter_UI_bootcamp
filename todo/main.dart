import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  String title;
  String description;

  Todo({
    required this.title,
    required this.description,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TODO APP"),
        ),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class TodoStorage {
  Future<List<Todo>> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList('todos');
    if (todoStrings != null) {
      return todoStrings.map((str) {
        List<String> parts = str.split('||');
        return Todo(
          title: parts[0],
          description: parts[1],
        );
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoStrings = todos.map((todo) => '${todo.title}||${todo.description}').toList();
    await prefs.setStringList('todos', todoStrings);
  }
}

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(storage: TodoStorage()),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  late TodoStorage storage;
  MyStatefulWidget({required this.storage});

  MainList createState() => MainList();
}

class MainList extends State<MyStatefulWidget> {
  List<Todo> todolist = [];

  late String title_task;
  late String description_task;

  addTodo(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add new task"),
        content: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  title_task = value; // Update instance variables inside setState
                });
              },
              decoration: const InputDecoration(hintText: "Title of task"),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  description_task = value; // Update instance variables inside setState
                });
              },
              decoration: const InputDecoration(hintText: "Description of task"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (title_task != null || description_task != null) {
                  todolist.add(Todo(title: title_task, description: description_task));
                  Navigator.pop(context);
                };
              });
              saveList();
            }, 
            child: Text("OK"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("CANCEL"),
          )
        ],
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadList();
  }

  Future<void> loadList() async {
    List<Todo> loadedTodos = await widget.storage.loadTodos();
    setState(() {
      todolist = loadedTodos;
    });
  }

  Future<void> saveList() async {
    await widget.storage.saveTodos(todolist);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (context, index) {
          final todo = todolist[index];

          return ListTile(
            title: Text(todo.title),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoDetailPage(todo: todo)),
              );
              if (result == 'DELETE') {
                setState(() {
                  todolist.removeAt(index);
                });
              }
              saveList();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addTodo(context);
        },
      ),
    );
  }
}

class TodoDetailPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Text(todo.description),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_forever),
        onPressed: () {
          Navigator.pop(context, "DELETE");
        },
      ),
    );
  }
}