// main.dart
import 'package:flutter/material.dart';
import 'home_page.dart'; // Importing Home Page

void main() {
  runApp(ExoplanetApp());
}

class ExoplanetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exoplanet Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Set HomePage as the initial route
    );
  }
}
