import 'package:flutter/material.dart';
import 'package:learning/UI/list_users.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME PAGE'),
        backgroundColor: Colors.red,
        leading: Icon(Icons.home),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenido a la página principal'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListUsers()));
            },
            child: Text('Ver Lista de usuarios'),
            )
          ],
        ),
      )
    );
  }
}