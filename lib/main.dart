import 'package:flutter/material.dart';
import 'cars_list_screen.dart';
import 'package:provider/provider.dart';
import 'car_provider.dart';
import 'joke_provider.dart';
import 'joke_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()..fetchCars()),
        ChangeNotifierProvider(create: (_) => JokeProvider()..fetchNewJoke()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P5d API Cars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: JokeScreen(),
    );
  }
}

