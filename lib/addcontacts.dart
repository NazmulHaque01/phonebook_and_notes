import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<void> saveContactsToFile(String name, String phoneNumber) async {
    Map<String, String> contact = {
      "name": name,
      "phoneNumber": phoneNumber
    };
    final file = File("${await _localPath}/contacts_file.json");
    String fileContent;
    if (await file.exists()) {
      fileContent = await file.readAsString();
    } else {
      fileContent = '[]';
    }
    List<dynamic> contacts = jsonDecode(fileContent);
    contacts.add(contact);
    String jsonAsString = jsonEncode(contacts);
    await file.writeAsString(jsonAsString);
    nameController.clear();
    phoneNumberController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Name"),
          ),
        ),
        Padding(padding: EdgeInsets.all(20), child: TextField( controller: phoneNumberController, decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Phone Number"),),),
        Padding(padding: const EdgeInsets.all(20), child: ElevatedButton(onPressed: (){
          saveContactsToFile(nameController.text, phoneNumberController.text);
          }, child: Text("Add Contact", style: TextStyle(color: Colors.black, fontSize: 20)),)),
      ],
    );
  }
}