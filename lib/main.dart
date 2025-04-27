import 'package:flutter/material.dart';
import 'package:lks_project_new/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LKS Mart V2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)   ,
        useMaterial3: true
      ),
      home: const LoginScreenStateful(),
    );
  }
}