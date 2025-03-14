import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main(){
  runApp(const StudioGhibliApp());
}

class StudioGhibliApp extends StatelessWidget {
  const StudioGhibliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Studio Ghibli',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.comfortable,
      ),
      home: const HomeScreen(),
    );
  }
}