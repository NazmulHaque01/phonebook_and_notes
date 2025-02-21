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
  // Map<String,dynamic> phonebook = {};

  @override
  void initState(){
    super.initState();
  }

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<List<Map<String, String>>> readFile() async {
    final file = File('${await _localPath}/contacts_file.json');
    if (await file.exists()) {
      String contents = await file.readAsString();
      List<dynamic> decodedJson = jsonDecode(contents);
      return decodedJson.map((item) => Map<String, String>.from(item)).toList();
    } else {
      return List.empty();
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: readFile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Snapshot has Error: ${snapshot.error}');
          }
          final listData = snapshot.data;
          if (listData != null && listData.isNotEmpty) {
            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(50, 58, 60, 58),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        listData[index]['name']!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        listData[index]['phoneNumber']!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}