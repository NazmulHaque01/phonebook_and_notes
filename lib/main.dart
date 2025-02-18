import 'package:flutter/material.dart';
import 'phonebook.dart';
import 'addcontacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonebook & Notebook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Phonebook & Notebook"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Add Contacts",
                  icon: Icon(Icons.add_box_rounded),
                ),
                Tab(
                  text: "Phonebook",
                  icon: Icon(Icons.contacts),
                ),
                // Tab(
                //   text: "Add Notes",
                //   icon: Icon(Icons.add_box_rounded),
                // ),
                // Tab(
                //   text: "Notes",
                //   icon: Icon(Icons.notes),
                // ),
              ],
            ),
          ),
          body: TabBarView(children: [
            AddContacts(),
            Phonebook(),
            // AddNotes(),
          ])
      ),
    );
  }
}
