import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class Phonebook extends StatefulWidget{
  const Phonebook({super.key});

  @override
  State<Phonebook> createState() => _PhonebookState();
}

class _PhonebookState extends State<Phonebook> {
  File file= File("contacts.json");
  Map<String,dynamic> phonebook = {};

  @override
  void initState(){
    super.initState();
    readFile();
  }

  void readFile() async{
    try{
      String contents = await file.readAsString();
      setState(() {
        phonebook = jsonDecode(contents);
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: phonebook.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(phonebook.keys.elementAt(index)),
          subtitle: Text(phonebook.values.elementAt(index)),
        );
      }
    );
  }
}