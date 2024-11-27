import 'package:flutter/material.dart';
import 'package:learning/UI/add_user.dart';
import 'package:learning/UI/update_user.dart';
import 'package:learning/database/db.dart';
import 'package:provider/provider.dart';

import 'package:drift/drift.dart' as dr;

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  late Future<List<User>> userFuture;

  @override
  void initState() {
    super.initState();

    userFuture = loadData();
  }

  Future<List<User>> loadData()
  {
    final db = Provider.of<AppDatabase>(context, listen: false);

    return db.getListUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text('List users'),
        backgroundColor: Colors.red
      ),
      body: FutureBuilder<List<User>>(
        future: userFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay usuarios"));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser(id: user.id, name: user.name, email: user.email,)));

                          setState(() {
                            userFuture = loadData();
                          });
                        },
                        icon: Icon(Icons.edit)
                      ),
                      IconButton(
                        onPressed: (){
                          _deleteAdvice(user.name, user.email, user.id);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser()));

          setState(() {
            userFuture = loadData();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
   void _deleteAdvice(String name, String email, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final db = Provider.of<AppDatabase>(context, listen: false);
        return AlertDialog(
          title: const Text('DELETE USER'),
          content: Text('Are you sure you want to delete the user with name: ${name} and email: ${email}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                
                await db.deleteUser(UsersCompanion(id: dr.Value(id),name: dr.Value(name), email: dr.Value(email)));

                Navigator.pop(context);

                setState(() {
                  userFuture = loadData();
                });
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
      },
    );
  }
}