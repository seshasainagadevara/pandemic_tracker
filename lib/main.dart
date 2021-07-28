import 'package:flutter/material.dart';

import 'visible_layer/EntryScreen.dart';
import 'visible_layer/home_screen.dart';
import 'visible_layer/login_screen.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xivah',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: EntryScreen(),
      routes: {
        "/login": (BuildContext context) => LoginScreen(),
        "/home": (BuildContext context) => HomeScreen(),
      },
    );
  }
}
