import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Phonebook extends StatefulWidget{
  const Phonebook({super.key});

  @override
  State<Phonebook> createState() => _PhonebookState();
}

class _PhonebookState extends State<Phonebook> {
  Map<String,dynamic> phonebook = {};

  @override
  void initState(){
    super.initState();
    readFile();
  }

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Map<String, dynamic>> readFile() async {
    final file = File("${await _localPath}/contacts.json");
    String contents = await file.readAsString();
    return jsonDecode(contents);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: readFile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          phonebook = snapshot.data!;
          return ListView.builder(itemCount: phonebook.length, itemBuilder: (context, index) { return ListTile(title: Text(phonebook.keys.elementAt(index)), subtitle: Text(phonebook.values.elementAt(index)),);});
        }
      },
    );
  }
}