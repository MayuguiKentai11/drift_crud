import 'package:flutter/material.dart';
import 'package:learning/database/db.dart';
import 'package:provider/provider.dart';

import 'package:drift/drift.dart' as dr;

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {


  late AppDatabase appDatabase;

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.app_registration),
        title: Text('Agregar Informacion'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back)
              )
            ],
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Ingrese nombre",
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
              hintText: "Ingrese email",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              if(_nameController.text.isEmpty || _emailController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all the corresponding fields.')));
                return;
              }

              var validation = await appDatabase.insertUser(UsersCompanion(name: dr.Value(_nameController.text), email: dr.Value(_emailController.text)));

              if(validation != 0)
              {

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ADDED CORRECTLY!')));

                await Future.delayed(Duration(seconds: 1));

                Navigator.pop(context);
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong!')));
            }, 
            child: Text('AGREGAR')
          )
        ],
        
      )
    );
    
  }

}