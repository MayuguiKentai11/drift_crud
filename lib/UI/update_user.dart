import 'package:flutter/material.dart';
import 'package:learning/database/db.dart';
import 'package:provider/provider.dart';

import 'package:drift/drift.dart' as dr;

class UpdateUser extends StatefulWidget {

  final int id;

  final String name;

  final String email;

  const UpdateUser({super.key, required this.id, required this.name, required this.email});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  late AppDatabase db;

  @override
  void initState() {
    super.initState();
    
    _nameController.text = widget.name;

    _emailController.text = widget.email;
  }

  @override
  void dispose() {

    _nameController.dispose();

    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    db = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Informacion'),
        leading: Icon(Icons.edit),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
            ],
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Nombre",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Email",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              if(_nameController.text.isEmpty || _emailController.text.isEmpty)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all the corresponding fields.')));
                return;
              }
              var validation = await db.updateUser(UsersCompanion(id: dr.Value(widget.id),name: dr.Value(_nameController.text), email: dr.Value(_emailController.text)));

              if(validation)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Updated correctly!')));

                await Future.delayed(Duration(seconds: 1));

                Navigator.pop(context);
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Something went wrong')));
            },
            child: Text('GUARDAR'),
          )
        ],
      ),
    );
  }
}