import 'package:flutter/material.dart';
import 'package:untitled/MyStatefulWidget.dart';
import 'package:untitled/MyStatefulWidgetCompleted.dart';
import 'package:untitled/MyStateWidgetIncomplete.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test"),),
      body: const MyStatefulWidget(),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Choose The Category")),
            ListTile(
              title: const Text("Get all tasks"),
              onTap: () {
                print("All Tasks");
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                );
              },
            ),
            ListTile(
              title: const Text("Complete"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => MyStatefulWidgetCompleted()),
                );
              },
            ),
            ListTile(
              title: const Text("Incomplete"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => MyStateWidgetIncomplete()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}