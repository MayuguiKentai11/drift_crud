


import 'package:flutter/material.dart';

class DeleteUserModal extends StatefulWidget {

  final String name;

  final String email;
  
  const DeleteUserModal({super.key, required String this.name, required String this.email});

  @override
  State<DeleteUserModal> createState() => _DeleteUserModalState();
}

class _DeleteUserModalState extends State<DeleteUserModal> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('DELETE USER'),
      content: Text('Are you sure you want to delete the user with name: ${widget.name} and email: ${widget.email}'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () async {
            print("hello");
            
          },
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
  }
}