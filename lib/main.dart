import 'package:flutter/material.dart';
import 'package:learning/UI/home_page.dart';
import 'package:learning/database/db.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      dispose: (_, db) => db.close(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: HomePage(),
      )
    );
  }
}


