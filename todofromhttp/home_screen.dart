import 'package:flutter/material.dart';
import 'package:untitled/MyStatefulWidget.dart';
import 'package:untitled/MyStatefulWidgetCompleted.dart';
import 'package:untitled/MyStateWidgetIncomplete.dart';
import 'package:untitled/CustomGet.dart';
import 'package:untitled/CustomGetID.dart';

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
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
                );
              },
            ),
            ListTile(
              title: const Text("Complete"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const MyStatefulWidgetCompleted()),
                );
              },
            ),
            ListTile(
              title: const Text("Incomplete"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const MyStateWidgetIncomplete()),
                );
              },
            ),
            ListTile(
              title: const Text("Custom Todoid"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const CustomGet()),
                );
              },
            ),
            ListTile(
              title: const Text("Custom userId"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const CustomGetId()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}