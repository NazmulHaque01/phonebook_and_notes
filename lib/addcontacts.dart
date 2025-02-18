import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

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
          setState(() async {
            Map<String, String> contact = {
              "name": nameController.text,
              "phoneNumber": phoneNumberController.text
            };
            String jSonStringFormated = jsonEncode(contact);
            File file = File("contacts.json");
            await file.writeAsString('$jSonStringFormated\n', mode: FileMode.append);
          });
        }, child: Text("Add Contact", style: TextStyle(color: Colors.black, fontSize: 20)),)),
      ],
    );
  }
}